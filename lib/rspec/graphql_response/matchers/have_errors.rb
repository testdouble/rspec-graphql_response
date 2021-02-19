module RSpec
  module GraphQLResponse
    module Matchers
      module HaveErrors
        extend RSpec::Matchers::DSL

        matcher :have_errors do
          match do |response|
            have_errors = Validators::HaveErrors.new(response, expected_messages: @messages)
            return have_errors.validate
          end

          chain :with_messages do |*messages|
            @messages = messages
          end
        end
      end
    end
  end
end
