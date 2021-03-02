RSpec::GraphQLResponse.add_context_helper :graphql_query do |gql|
  @@graphql_query = gql
end
