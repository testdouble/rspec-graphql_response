require "rspec/graphql_response/version"
require "rspec/graphql_response/configuration"
require "rspec/graphql_response/matchers/be_successful"

module RSpec
  module GraphQL
    module Response
      extend RSpec::Matchers::DSL
      include RSpec::GraphQL::Response::Matchers::BeSuccessful

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
        config = GraphQL::Response.configuration

        config.graphql_schema.execute(query)
      end

      def response
        execute_graphql.to_h
      end
    end

    RSpec.configure do |config|
      config.include RSpec::GraphQL::Response, :type => :graphql
    end
  end
end
