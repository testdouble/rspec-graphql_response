require "rspec/graphql_response/version"
require "rspec/graphql_response/configuration"

require "rspec/graphql_response/validators/validation_base"
require "rspec/graphql_response/validators/validation_result"
require "rspec/graphql_response/validators/have_errors"

require "rspec/graphql_response/matchers/have_errors"

module RSpec
  module GraphQLResponse
    extend RSpec::Matchers::DSL
    include RSpec::GraphQLResponse::Matchers::HaveErrors

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
