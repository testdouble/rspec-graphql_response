module RSpec
  module GraphQLResponse
    module Validators
      class HaveErrors
        attr_reader :response, :expected_messages, :with_messages

        def initialize(response, expected_messages: [])
          @errors = []
          @response = response
          @expected_messages = Array(expected_messages)
          @with_messages = @expected_messages.length > 0
        end

        def validate
          return fail_validation if response.nil?

          errors = response.fetch("errors", [])
          return fail_validation if errors.length == 0

          if with_messages
            actual_messages = errors.map {|e| e["message"] }

            # they must match in count
            return fail_validation if expected_messages.length != actual_messages.length

            # join the two arrays, where items in each array match
            unmatched_messages = expected_messages & actual_messages

            # they must match in content. check for no messages matched
            return fail_validation if unmatched_messages.length == 0
          end

          pass_validation
        end

        private

        def fail_validation
          return false
        end

        def pass_validation
          true
        end
      end
    end
  end
end