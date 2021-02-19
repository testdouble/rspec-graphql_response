module RSpec
  module GraphQLResponse
    module Validators
      class ValidationResult
        def self.pass
          self.new(true)
        end

        def self.fail(reason)
          self.new(false, reason)
        end

        def valid?
          @is_valid
        end

        def reason(negated: false)
          @reason
        end

        private

        def initialize(is_valid, reason = nil)
          @is_valid = is_valid
          @reason = reason
        end
      end
    end
  end
end
