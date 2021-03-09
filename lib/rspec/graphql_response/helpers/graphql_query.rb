RSpec::GraphQLResponse.add_context_helper :graphql_query do |gql|
  self.define_method(:graphql_query) { gql }
end
