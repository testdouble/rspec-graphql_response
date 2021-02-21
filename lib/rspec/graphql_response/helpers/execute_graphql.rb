RSpec::GraphQLResponse.add_helper :execute_graphql do
  config = RSpec::GraphQLResponse.configuration
  config.graphql_schema.execute(query)
end
