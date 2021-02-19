module RSpec
  module GraphQLResponse
    module Validators
      class HaveErrors

        MESSAGES = {
          nil: "Cannot evaluate nil for errors",
          none: "Expected response to have errors, but found none"
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

            # they must match in count
            return fail_validation if expected_messages.length != actual_messages.length

            # join the two arrays, where items in each array match
            unmatched_messages = expected_messages & actual_messages

            # they must match in content. check for no messages matched
            return fail_validation if unmatched_messages.length == 0
          end

          ValidationResult.pass
        end

        private

        def fail_validation(reason)
          ValidationResult.fail(MESSAGES[reason])
        end
      end
    end
  end
end
