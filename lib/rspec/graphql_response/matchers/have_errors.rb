module RSpec
  module GraphQLResponse
    module Matchers
      module HaveErrors
        extend RSpec::Matchers::DSL

        matcher :have_errors do
          match do |response|
            @have_errors = Validators::HaveErrors.new(response, expected_messages: @messages)

            return @have_errors.validate
          end

          failure_message do |response|
            @have_errors.reason
          end

          failure_message_when_negated do |response|
            @have_errors.negated_reason
          end

          chain :with_messages do |*messages|
            @messages = messages
          end
        end
      end
    end
  end
end
