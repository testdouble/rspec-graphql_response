module RSpec
  module GraphQLResponse
    module Validators
      class ValidationBase
        protected

        def fail_validation(reason_type, *args)
          message = self.class::MESSAGES[reason_type]
          negated_message = self.class::NEGATED_MESSAGES[reason_type]
          ValidationResult.fail(message, negated_message, args)
        end

        def pass_validation
          ValidationResult.pass
        end
      end
    end
  end
end
