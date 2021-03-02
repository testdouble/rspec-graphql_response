RSpec.describe RSpec::GraphQLResponse, "helper#execute_graphql", type: :graphql do
  graphql_query <<-GQL
    query {
      characters {
        id,
        name
      }
    }
  GQL

  it "can execute graphql" do
    expect(response).to_not have_errors

    expect(response["data"]).to include(
      "characters" => [
        { "id" => "1", "name" => "Jam" },
        { "id" => "2", "name" => "Redemption" },
        { "id" => "3", "name" => "Pet" }
      ]
    )
  end
end
