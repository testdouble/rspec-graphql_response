RSpec.describe RSpec::GraphQLResponse, "helper#response", type: :graphql do
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

  it "uses execute_graphql to create a response" do
    expect(self).to receive(:execute_graphql).once.and_call_original

    expect(response).to_not be_nil
    expect(response["data"]).to include(
      "characters" => [
        { "id" => "1", "name" => "Jam" },
        { "id" => "2", "name" => "Redemption" },
        { "id" => "3", "name" => "Pet" }
      ]
    )
  end
end
