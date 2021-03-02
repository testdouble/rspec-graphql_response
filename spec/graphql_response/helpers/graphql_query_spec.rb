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

    expect(response["data"]).to include(
      "characters" => [
        { "id" => "1", "name" => "Jam" },
        { "id" => "2", "name" => "Redemption" },
        { "id" => "3", "name" => "Pet" }
      ]
    )
  end

  context "nested context" do
    it "still works" do
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
end
