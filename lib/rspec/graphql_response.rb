require_relative "graphql_response/configuration"
require_relative "graphql_response/validators"
require_relative "graphql_response/matchers"
require_relative "graphql_response/helpers"

module RSpec
  module GraphQLResponse
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
