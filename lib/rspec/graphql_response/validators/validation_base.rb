module RSpec
  module GraphQLResponse
    module Validators
      class ValidationBase
        class << self
          def failure_message(type, msg)
            @messages ||= {}
            @messages[type] = msg
          end

          def validate(&validate_method)
            @validate_method = validate_method
          end

          def validate_negated(&validate_negated_method)
            @validate_negated_method = validate_negated_method
          end
        end

        def validate(response, **args)
          validate_method = self.class.instance_variable_get(:@validate_method)

          runner = ValidationRunner.new(self)
          runner.instance_exec(response, **args, &validate_method)
        end

        def validate_negated(response, **args)
          validate_negated_method = self.class.instance_variable_get(:@validate_negated_method)

          runner = ValidationRunner.new(self)
          runner.instance_exec(response, **args, &validate_negated_method)
        end

        def failure_message(type)
          self.class.instance_variable_get(:@messages)[type]
        end
      end
    end
  end
end
