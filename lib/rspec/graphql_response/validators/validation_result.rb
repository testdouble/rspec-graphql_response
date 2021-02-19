module RSpec
  module GraphQLResponse
    module Validators
      class ValidationResult
        def self.pass
          self.new(true)
        end

        def self.fail(message)
          self.new(false, message)
        end

        def valid?
          @is_valid
        end

        private

        def initialize(is_valid, message = nil)
          @is_valid = is_valid
          @message = message
        end
      end
    end
  end
end
