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
    dig_dug = described_class.new(dig_pattern)
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

  it "can dig through an array" do
    expect(response_data :characters, :friends).to include(
      { "id" => "2", "name" => "Redemption" },
      { "id" => "1", "name" => "Jam" },
      { "id" => "3", "name" => "Pet" },
      { "id" => "2", "name" => "Redemption" }
    )
  end

  it "can dig through an array to nested fields" do
    expect(response_data :characters, :friends, :name).to include(
      "Redemption",
      "Jam",
      "Pet"
    )
  end

  it "can dig into an Array at the specified index" do
    expect(response_data characters: [1]).to eq(
      "id" => "2",
      "name" => "Redemption",
      "friends" => [
        { "id" => "1", "name" => "Jam" },
        { "id" => "3", "name" => "Pet" }
      ]
    )
  end

  it "can dig multiple levels into an Array at the specified index" do
    expect(response_data characters: [1], friends: [0]).to include(
      { "id" => "1", "name" => "Jam" },
    )
  end

  it "can dig into a Hash that came through an Array" do
    expect(response_data characters: [0], friends: [:name]).to eq(["Redemption"])
  end

  it "can dig multiple nested levels of hash and Array" do
    expect(response_data(:characters, {friends: [0]}, :name)).to eq "Jam"
  end

end
