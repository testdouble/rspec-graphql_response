RSpec.describe RSpec::GraphQLResponse, "helper#response", type: :graphql do
  graphql_operation <<-GQL
    query {
      characters {
        id,
        name,
        friends {
          id
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
              { "id" => "2", "name" => "Redemption" }
            ]
          },
          {
            "id" => "2",
            "name" => "Redemption",
            "friends" => [
              { "id" => "1", "name" => "Jam" },
              { "id" => "3", "name" => "Pet" }
            ]
          },
          {
            "id" => "3",
            "name" => "Pet",
            "friends" => [
              { "id" => "2", "name" => "Redemption" }
            ]
          }
        ]
      )
    end

    it "can dig to the first layer" do
      expect(response_data :characters).to include(
        {
          "id" => "1",
          "name" => "Jam",
          "friends" => [
            { "id" => "2", "name" => "Redemption" }
          ]
        },
        {
          "id" => "2",
          "name" => "Redemption",
          "friends" => [
            { "id" => "1", "name" => "Jam" },
            { "id" => "3", "name" => "Pet" }
          ]
        },
        {
          "id" => "3",
          "name" => "Pet",
          "friends" => [
            { "id" => "2", "name" => "Redemption" }
          ]
        }
      )
    end

    it "can dig through an array" do
      expect(response_data :characters, :friends).to include(
        { "id" => "2", "name" => "Redemption" },
        { "id" => "1", "name" => "Jam" },
        { "id" => "3", "name" => "Pet" },
        { "id" => "2", "name" => "Redemption" }
      )
    end

    it "can dig through an array to nested fields" do
      expect(response_data :characters, :friends).to include(
        "Redemption",
        "Jam",
        "Pet"
      )
    end

    it "can dig into an Array at the specified index" do
      expect(response_data characters: [1], friends: [0]).to include(
        { "name" => "Pet" },
      )
    end

    it "can shape the response" do
      expect(response_data characters: [0], friends: [:name]).to include(
        {
          "id" => "1",
          "name" => "Jam",
          "friends" => [
            { "name" => "Redemption" }
          ]
        }
      )
    end
  end
end
