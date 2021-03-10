RSpec.describe RSpec::GraphQLResponse, "helper#response", type: :graphql do
  graphql_query <<-GQL
    query {
      characters {
        id,
        name,
        friends {
          name
        }
      }
    }
  GQL

  context "has data returned" do
    it "can return the hash" do
      expect(response_data).to include(
        "characters" => [
          { "id" => "1", "name" => "Jam" },
          { "id" => "2", "name" => "Redemption" },
          { "id" => "3", "name" => "Pet" }
        ]
      )
    end

    it "can dig to a specific layer" do
    end
  end
end
