module RSpec
  module GraphQLResponse
    module Matchers
      module BeSuccessful
        extend RSpec::Matchers::DSL

        matcher :have_errors do
          match do |response|
            return false if response.nil?
            return response.fetch("errors", []).length > 0
          end

          match_when_negated { false }
        end
      end
    end
  end
end
