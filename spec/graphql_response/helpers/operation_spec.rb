RSpec.describe RSpec::GraphQLResponse, "helper#operation", type: :graphql do
  context "graphql response with no data" do
    it "returns nil" do
      characters = operation(:characters)

      expect(characters).to be_nil
    end
  end

  context "graphql response with data" do
    graphql_query <<-GQL
      query {
        characters {
          id,
          name
        }
      }
    GQL

    it "retrieves the named operation from the graphql response" do
      characters = operation(:characters)

      expect(characters).to_not be_nil
      expect(characters).to include(
        { "id" => "1", "name" => "Jam" },
        { "id" => "2", "name" => "Redemption" },
        { "id" => "3", "name" => "Pet" }
      )
    end
  end
end
