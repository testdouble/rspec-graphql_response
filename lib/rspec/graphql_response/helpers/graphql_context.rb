RSpec::GraphQLResponse.add_helper :graphql_context, scope: :describe do |ctx|
  @graphql_context = ctx
end
