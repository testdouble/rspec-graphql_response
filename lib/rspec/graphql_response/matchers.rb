# this must come first, so we can build the module
# with the extend RSpec Matchers DSL before
# defining the custom matchers
module RSpec
  module GraphQLResponse
    module Matchers
      extend RSpec::Matchers::DSL
    end
  end
end

require_relative "matchers/have_errors"
