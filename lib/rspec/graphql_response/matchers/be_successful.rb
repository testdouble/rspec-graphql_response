module RSpec
  module GraphQL
    module Response
      module Matchers
        module BeSuccessful
          extend RSpec::Matchers::DSL

          matcher :be_successful do |response|
            match { false }
            match_when_negated { false }
          end
        end
      end
    end
  end
end
