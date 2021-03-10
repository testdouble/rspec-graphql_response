RSpec::GraphQLResponse.add_helper :response_data do
  execute_graphql.to_h
end
