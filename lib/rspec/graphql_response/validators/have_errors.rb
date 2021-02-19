module RSpec
  module GraphQLResponse
    module Validators
      class HaveErrors

        MESSAGES = {
          nil: "Cannot evaluate nil for errors",
          none: "Expected response to have errors, but found none",
          unmatched: ->(expected, actual) { "Expected\n\t#{expected.inspect}\nbut found\n\t#{actual.inspect}" }
        }

        attr_reader :response, :expected_messages, :with_messages

        def initialize(response, expected_messages: [])
          @response = response
          @expected_messages = Array(expected_messages)
          @with_messages = @expected_messages.length > 0
        end

        def validate
          return fail_validation(:nil) if response.nil?

          errors = response.fetch("errors", [])
          return fail_validation(:none) if errors.length == 0

          if with_messages
            actual_messages = errors.map {|e| e["message"] }
            unmatched_messages = expected_messages.difference(actual_messages)

            return fail_validation(:unmatched, expected_messages, actual_messages) if unmatched_messages.any?
          end

          ValidationResult.pass
        end

        private

        def fail_validation(reason, *args)
          message = MESSAGES[reason]

          if message.is_a? Proc
            message = message.call(*args)
          end

          ValidationResult.fail(message)
        end
      end
    end
  end
end
