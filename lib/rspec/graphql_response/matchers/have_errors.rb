module RSpec
  module GraphQLResponse
    module Matchers
      module HaveErrors
        extend RSpec::Matchers::DSL

        matcher :have_errors do
          match do |response|
            have_errors = Validators::HaveErrors.new(response, expected_messages: @messages)

            @result = have_errors.validate
            @result.valid?
          end

          failure_message do |response|
            @reason.reason
          end

          failure_message_when_negated do |response|
            @reason.negated_reason
          end

          chain :with_messages do |*messages|
            @messages = messages
          end
        end
      end
    end
  end
end
