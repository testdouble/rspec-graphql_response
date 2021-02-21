module RSpec
  module GraphQLResponse
    def self.add_helper(name, &helper)
      helper_module = Module.new do |mod|
        mod.define_method(name) do |*args|
          @result ||= self.instance_exec(*args, &helper)
        end
      end

      RSpec.configure do |config|
        config.after(:each) do
          helper_module.instance_variable_set(:@result, nil)
        end
      end

      self.include(helper_module)
    end
  end
end

require_relative "helpers/operation"
require_relative "helpers/response"
require_relative "helpers/execute_graphql"
