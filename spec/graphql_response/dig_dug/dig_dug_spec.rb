RSpec.describe RSpec::GraphQLResponse::DigDug do
  let(:response) do
    {
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
    }
  end

  let(:dig_pattern) { nil }

  subject(:dig) do
    dig_dug = described_class.new(*dig_pattern)
    dig_dug.dig(response)
  end

  context "dig one layer" do
    let(:dig_pattern) { [:characters] }

    it "returns the correct data" do
      expect(dig).to include(
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
  end

  context "dig through an array" do
    let(:dig_pattern) { [:characters, :friends] }

    it "returns the correct data" do
      expect(dig).to include(
        { "id" => "2", "name" => "Redemption" },
        { "id" => "1", "name" => "Jam" },
        { "id" => "3", "name" => "Pet" },
        { "id" => "2", "name" => "Redemption" }
      )
    end
  end

  context "dig through an array to nested fields" do
    let(:dig_pattern) { [:characters, :friends, :name] }

    it "returns the correct data" do
      expect(dig).to include(
        "Redemption",
        "Jam",
        "Pet"
      )
    end
  end

  context "dig into an Array at the specified index" do
    let(:dig_pattern) { [characters: [1]] }

    it "returns the correct data" do
      expect(dig).to eq(
        "id" => "2",
        "name" => "Redemption",
        "friends" => [
          { "id" => "1", "name" => "Jam" },
          { "id" => "3", "name" => "Pet" }
        ]
      )
    end
  end

  context "dig multiple levels into an Array at the specified index" do
    let(:dig_pattern) { [characters: [1], friends: [0]] }

    it "returns the correct data" do
      expect(dig).to include(
        { "id" => "1", "name" => "Jam" }
      )
    end
  end

  context "dig into a Hash that came through an Array" do
    let(:dig_pattern) { [characters: [0], friends: [:name]] }

    it "returns the correct data" do
      expect(dig).to eq(["Redemption"])
    end
  end

  context "dig indexed item of value from hash that came through an array" do
    let(:dig_pattern) { [:characters, friends: [1]] }

    it "returns the correct data" do
      expect(dig).to include(
        { "id" => "3", "name" => "Pet" }
      )
    end
  end

  context "dig multiple nested levels of hash and Array" do
    let(:dig_pattern) { [:characters, {friends: [1]}, :name] }

    it "returns the correct data" do
      expect(dig).to eq ["Pet"]
    end
  end
end
