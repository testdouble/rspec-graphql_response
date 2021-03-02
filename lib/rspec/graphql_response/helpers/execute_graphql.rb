RSpec::GraphQLResponse.add_helper :execute_graphql do
  config = RSpec::GraphQLResponse.configuration

  klass = self.class
  has_var = klass.method(:class_variable_defined?)
  get_var = klass.method(:class_variable_get)

  query = get_var.call(:@@graphql_query) if has_var.call(:@@graphql_query)
  query_vars = get_var.call(:@@graphql_variables) if has_var.call(:@@graphql_variables)
  query_context = get_var.call(:@@graphql_context) if has_var.call(:@@graphql_context)

  config.graphql_schema.execute(query, {
    variables: query_vars,
    context: query_context
  })
end
