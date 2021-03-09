RSpec::GraphQLResponse.add_context_helper :graphql_context do |ctx|
  self.define_method(:graphql_context) { ctx }
end
