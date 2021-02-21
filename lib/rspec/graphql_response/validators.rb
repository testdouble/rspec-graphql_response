require_relative "validators/validation_base"

module RSpec
  module GraphQLResponse
    def self.add_validator(name, &validator)
      validator_class = Class.new(Validators::ValidationBase, &validator)
      const_name = name.to_s.split('_').collect(&:capitalize).join
      Validators.const_set(const_name, validator_class)
    end

    def self.validator(name)
      const_name = name.to_s.split('_').collect(&:capitalize).join
      Validators.const_get(const_name)
    end
  end
end

require_relative "validators/have_errors"
