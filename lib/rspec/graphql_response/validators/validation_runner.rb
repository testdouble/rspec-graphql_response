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
          ValidationResult.fail(message, args)
        end

        def pass_validation
          ValidationResult.pass
        end

      end
    end
  end
end
