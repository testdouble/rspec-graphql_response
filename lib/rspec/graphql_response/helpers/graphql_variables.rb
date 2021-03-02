RSpec::GraphQLResponse.add_context_helper :graphql_variables do |vars|
  @@graphql_variables = vars
end
