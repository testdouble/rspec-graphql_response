module RSpec
  module GraphQLResponse
    module Validators
      class ValidationResult
        def self.pass
          self.new(true)
        end

        def self.fail(reason, negated_reason, args)
          self.new(false, reason, negated_reason, args)
        end

        def valid?
          @is_valid
        end

        def reason
          if @reason.is_a? Proc
            @reason = @reason.call(*@args)
          end

          @reason
        end

        def negated_reason
          if @negated_reason.is_a? Proc
            @negated_reason = @negated_reason.call(*@args)
          end

          @negated_reason
        end

        private

        def initialize(is_valid, reason = nil, negated_reason = nil, args = [])
          @is_valid = is_valid
          @reason = reason
          @negated_reason = negated_reason
          @args = args
        end
      end
    end
  end
end
