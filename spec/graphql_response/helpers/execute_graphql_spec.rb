RSpec.describe RSpec::GraphQLResponse, "helper#execute_graphql", type: :graphql do
  graphql_query <<-GQL
    query {
      characters {
        id,
        name
      }
    }
  GQL

  it "can execute graphql using a let(:query)" do
    response = execute_graphql.to_h
    expect(response).to_not be_nil

    expect(response["data"]).to include(
      "characters" => [
        { "id" => "1", "name" => "Jam" },
        { "id" => "2", "name" => "Redemption" },
        { "id" => "3", "name" => "Pet" }
      ]
    )
  end
end
