module RSpec
  module GraphQLResponse
    module Validators
      class ValidationBase
        class << self
          def failure_message(type, msg)
            @messages ||= {}
            @messages[type] = msg
          end

          def failure_message_negated(type, msg)
            @negated_messages ||= {}
            @negated_messages[type] = msg
          end
        end

        protected

        def fail_validation(type, *args)
          message = failure_message(type)
          negated_message = failure_message_negated(type)
          ValidationResult.fail(message, negated_message, args)
        end

        def pass_validation
          ValidationResult.pass
        end

        private

        def failure_message(type)
          self.class.instance_variable_get(:@messages)[type]
        end

        def failure_message_negated(type)
          self.class.instance_variable_get(:@negated_messages)[type]
        end
      end
    end
  end
end
