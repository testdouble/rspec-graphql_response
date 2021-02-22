module RSpec
  module GraphQLResponse
    module Validators
      class ValidationResult
        def self.pass
          self.new(true)
        end

        def self.fail(reason, args)
          self.new(false, reason, args)
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

        private

        def initialize(is_valid, reason = nil, args = [])
          @is_valid = is_valid
          @reason = reason
          @args = args
        end
      end
    end
  end
end
