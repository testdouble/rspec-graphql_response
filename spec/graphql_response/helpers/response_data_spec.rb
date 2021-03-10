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
          {
            "id" => "1",
            "name" => "Jam",
            "friends" => [
              { "name" => "Redemption" }
            ]
          },
          {
            "id" => "2",
            "name" => "Redemption",
            "friends" => [
              { "name" => "Pet" },
              { "name" => "Jam" }
            ]
          },
          {
            "id" => "3",
            "name" => "Pet",
            "friends" => [
              { "name" => "Redemption" }
            ]
          }
        ]
      )
    end

    it "can dig to a specific layer" do
      expect(response_data :characters).to include(
        {
          "id" => "1",
          "name" => "Jam",
          "friends" => [
            { "name" => "Redemption" }
          ]
        },
        {
          "id" => "2",
          "name" => "Redemption",
          "friends" => [
            { "name" => "Pet" },
            { "name" => "Jam" }
          ]
        },
        {
          "id" => "3",
          "name" => "Pet",
          "friends" => [
            { "name" => "Redemption" }
          ]
        }
      )
    end
  end
end
