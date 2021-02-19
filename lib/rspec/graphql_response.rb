require "rspec/graphql_response/version"
require "rspec/graphql_response/configuration"
require "rspec/graphql_response/matchers/be_successful"

module RSpec
  module GraphQLResponse
    extend RSpec::Matchers::DSL
    include RSpec::GraphQLResponse::Matchers::BeSuccessful

    def self.configure(&block)
      return if block.nil?

      block.call(configuration)
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.reset_configuration
      @configuration = nil
    end

    def execute_graphql
      config = GraphQLResponse.configuration

      config.graphql_schema.execute(query)
    end

    def response
      execute_graphql.to_h
    end
  end

  RSpec.configure do |config|
    config.include RSpec::GraphQLResponse, :type => :graphql
  end
end
