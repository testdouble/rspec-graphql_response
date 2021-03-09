RSpec::GraphQLResponse.add_helper :execute_graphql do
  config = RSpec::GraphQLResponse.configuration

  query = graphql_query if respond_to? :graphql_query
  query_vars = graphql_variables if respond_to? :graphql_variables
  
  query_context = graphql_context if respond_to? :graphql_context
  query_context = self.instance_eval(&query_context) if query_context.is_a? Proc

  config.graphql_schema.execute(query, {
    variables: query_vars,
    context: query_context
  })
end
