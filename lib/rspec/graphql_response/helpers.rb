module RSpec
  module GraphQLResponse
    def self.add_helper(name, &helper)
      helper_module = Module.new do |mod|
        mod.define_method(name, &helper)
      end

      self.include(helper_module)
    end
  end
end

require_relative "helpers/operation"
