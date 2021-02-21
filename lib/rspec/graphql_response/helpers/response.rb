RSpec::GraphQLResponse.add_helper :response do
  execute_graphql.to_h
end
