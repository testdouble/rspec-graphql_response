module RSpec
  module GraphQLResponse
    module Helpers
      def operation(name)
        return nil unless response.is_a? Hash

        response.dig("data", name.to_s)
      end
    end
  end
end
