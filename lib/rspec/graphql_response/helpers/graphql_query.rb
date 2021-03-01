RSpec::GraphQLResponse.add_helper :graphql_query, scope: :describe do |gql|
  @graphql_query = gql
end
