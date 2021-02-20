module RSpec
  module GraphQLResponse
    module Validators
      class HaveErrors

        MESSAGES = {
          nil: "Cannot evaluate nil for errors",
          none: "Expected response to have errors, but found none",
          unmatched: ->(expected, actual) { "Expected\n\t#{expected.inspect}\nbut found\n\t#{actual.inspect}" },
          length: ->(expected, actual) { "Expected response to have #{expected} errors, but found #{actual}" }
        }

        NEGATED_MESSAGES = {

        }

        attr_reader :response, :expected_messages, :with_messages, :expected_count, :with_count

        def initialize(response, expected_messages: [], expected_count: nil)
          @response = response

          @expected_messages = Array(expected_messages)
          @with_messages = @expected_messages.length > 0

          @expected_count = expected_count
          @with_count = !@expected_count.nil?
        end

        def validate
          return fail_validation(:nil) if response.nil?

          errors = response.fetch("errors", [])
          return fail_validation(:none) if errors.length == 0

          if with_count
            actual_count = errors.length
            return fail_validation(:length, expected_count, actual_count) if expected_count != actual_count
          end

          if with_messages
            actual_messages = errors.map {|e| e["message"] }
            unmatched_messages = expected_messages.difference(actual_messages)

            return fail_validation(:unmatched, expected_messages, actual_messages) if unmatched_messages.any?
          end

          ValidationResult.pass
        end

        private

        def fail_validation(reason_type, *args)
          message = MESSAGES[reason_type]
          negated_message = NEGATED_MESSAGES[reason_type]
          ValidationResult.fail(message, negated_message, args)
        end
      end
    end
  end
end
