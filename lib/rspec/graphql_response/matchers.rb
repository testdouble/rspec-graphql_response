module RSpec
  module GraphQLResponse
    def self.add_matcher(name, &matcher)
      matcher = Module.new do |mod|
        extend RSpec::Matchers::DSL
        matcher(name, &matcher)
      end

      self.include(matcher)
    end
  end
end

require_relative "matchers/have_errors"
