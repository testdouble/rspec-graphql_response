RSpec.describe RSpec::GraphQLResponse, "graphql_query helper", type: :graphql do
  graphql_query <<-GQL
    query CharacterList {
      characters {
        id
        name
      }
    }
  GQL

  it "executes the supplied graphql query" do
    expect(response).to_not have_errors
    expect(response["data"]["characters"]).to_not be_nil

    # expect(response).to have_operation(:characters)
  end
end
