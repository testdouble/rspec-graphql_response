RSpec.describe RSpec::GraphQLResponse, "graphql_variables helper", type: :graphql do
  graphql_query <<-GQL
    query CharacterList($name: String) {
      characters(name: $name) {
        id
        name
      }
    }
  GQL

  graphql_variables({
    "name" => "Jam"
  })

  it "uses the supplied variables to execute the graphql query" do
    expect(response).to_not have_errors

    expect(response["data"]).to include(
      "characters" => [
        { "id" => "1", "name" => "Jam" },
      ]
    )
  end
end
