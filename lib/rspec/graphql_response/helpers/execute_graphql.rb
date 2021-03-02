RSpec::GraphQLResponse.add_helper :execute_graphql do
  config = RSpec::GraphQLResponse.configuration

  query = get_graphql_query if respond_to? :get_graphql_query
  query_vars = get_graphql_variables if respond_to? :get_graphql_variables
  query_context = get_graphql_context if respond_to? :get_graphql_context

  config.graphql_schema.execute(query, {
    variables: query_vars,
    context: query_context
  })
end
