require "spec_helper"

RSpec.describe RSpec::GraphQLResponse::Helpers, type: :graphql do
  context "graphql response with no data" do
    let(:query) { }

    it "returns nil" do
      characters = operation(:characters)

      expect(characters).to be_nil
    end
  end

  context "graphql response with data" do
    let(:query) do
      <<-GQL
        query {
          characters {
            id,
            name
          }
        }
      GQL
    end

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
