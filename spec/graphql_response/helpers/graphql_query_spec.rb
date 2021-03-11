RSpec.describe RSpec::GraphQLResponse, "graphql_operation helper", type: :graphql do
  graphql_operation <<-GQL
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

  context "proc as value" do
    graphql_operation do
      <<-GQL
        query CharacterList {
          characters {
            name
          }
        }
      GQL
    end

    it "provides access to let vars through a proc as value" do
      expect(response).to_not have_errors

      expect(response["data"]).to include(
        "characters" => [
          { "name" => "Jam" },
          { "name" => "Redemption" },
          { "name" => "Pet" }
        ]
      )
    end
  end
end
