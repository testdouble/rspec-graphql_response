RSpec::GraphQLResponse.add_helper :execute_graphql do
  config = RSpec::GraphQLResponse.configuration

  query = self.class.instance_variable_get(:@graphql_query)
  config.graphql_schema.execute(query)
end
