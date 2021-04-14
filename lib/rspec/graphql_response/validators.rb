require_relative "validators/validation_result"
require_relative "validators/validation_base"
require_relative "validators/validation_runner"

module RSpec
  module GraphQLResponse
    def self.add_validator(name, &validator)
      @validators ||= {}

      validator_class = Class.new(Validators::ValidationBase, &validator)
      @validators[name] = validator_class
    end

    def self.remove_validator(name)
      @validators ||= {}
      @validators.delete(:key)
    end

    def self.validator(name)
      @validators[name].new
    end
  end
end

require_relative "validators/have_errors"
require_relative "validators/have_field"
