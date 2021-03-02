RSpec::GraphQLResponse.add_context_helper :graphql_context do |ctx|
  self.define_method(:get_graphql_context) { ctx }
end
