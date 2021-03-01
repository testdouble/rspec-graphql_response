RSpec::GraphQLResponse.add_helper :execute_graphql do
  config = RSpec::GraphQLResponse.configuration

  query = self.class.instance_variable_get(:@graphql_query)
  query_vars = self.class.instance_variable_get(:@graphql_variables)

  config.graphql_schema.execute(query, {
    variables: query_vars
  })
end
