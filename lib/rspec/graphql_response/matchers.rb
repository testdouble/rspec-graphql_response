module RSpec
  module GraphQLResponse
    def self.add_matcher(name, &matcher)
      matcher_module = Module.new do |mod|
        extend RSpec::Matchers::DSL
        matcher(name, &matcher)
      end

      self.include(matcher_module)
    end
  end
end

require_relative "matchers/have_errors"
require_relative "matchers/have_operation"
