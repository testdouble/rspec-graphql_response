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

          def validate(&validation_method)
            @validation_method = validation_method
          end
        end

        def validate(response, *args)
          validation_method = self.class.instance_variable_get(:@validation_method)

          runner = ValidationRunner.new(self)
          runner.instance_exec(response, *args, &validation_method)
        end

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
