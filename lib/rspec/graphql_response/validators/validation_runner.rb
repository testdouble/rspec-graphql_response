module RSpec
  module GraphQLResponse
    module Validators
      class ValidationRunner
        attr_reader :validator

        def initialize(validator)
          @validator = validator
        end

        protected

        def fail_validation(type, *args)
          message = validator.failure_message(type)
          negated_message = validator.failure_message_negated(type)
          ValidationResult.fail(message, negated_message, args)
        end

        def pass_validation
          ValidationResult.pass
        end

      end
    end
  end
end
