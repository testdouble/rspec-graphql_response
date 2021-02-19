module RSpec
  module GraphQLResponse
    module Matchers
      module BeSuccessful
        extend RSpec::Matchers::DSL

        matcher :have_errors do |response|
          match { false }
          match_when_negated { false }
        end
      end
    end
  end
end
