RSpec::GraphQLResponse.add_context_helper :graphql_operation do |gql|
  self.define_method(:graphql_operation) { gql }
end
