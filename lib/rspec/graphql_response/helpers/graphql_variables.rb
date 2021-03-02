RSpec::GraphQLResponse.add_context_helper :graphql_variables do |vars|
  self.define_method(:get_graphql_variables) { vars }
end
