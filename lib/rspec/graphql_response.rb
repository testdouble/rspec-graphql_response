require "rspec/graphql_response/version"
require "rspec/graphql_response/configuration"

module RSpec
  module GraphQL
    module Response
      extend RSpec::Matchers::DSL

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
        raise "GraphQL Schema not found. Please set config.graphql_schema = ..." if config.nil?

        config.graphql_schema.execute(

        )
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
