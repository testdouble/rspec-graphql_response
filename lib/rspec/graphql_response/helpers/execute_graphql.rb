RSpec::GraphQLResponse.add_helper :execute_graphql do
  config = RSpec::GraphQLResponse.configuration

  operation = graphql_operation if respond_to? :graphql_operation
  operation = self.instance_eval(&graphql_operation) if operation.is_a? Proc

  operation_vars = graphql_variables if respond_to? :graphql_variables
  operation_vars = self.instance_eval(&graphql_variables) if operation_vars.is_a? Proc

  operation_context = graphql_context if respond_to? :graphql_context
  operation_context = self.instance_eval(&operation_context) if operation_context.is_a? Proc

  config.graphql_schema.execute(operation, variables: operation_vars, context: operation_context)
end
