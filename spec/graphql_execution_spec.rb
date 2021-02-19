RSpec.describe "GrapQL Execution", type: :graphql do
  let(:query) do
    <<~GQL
      query CharacterList {
        characters {
          id
          name
        }
      }
    GQL
  end

  it "executes the graphql call when 'response' is accessed" do
    expect(ExampleSchema).to receive(:execute).and_call_original

    expect(response).to_not be_nil
  end
end
