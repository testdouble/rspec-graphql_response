RSpec.describe RSpec::GraphQLResponse, "#add_helper", type: :graphql do
  RSpec::GraphQLResponse.add_helper :example_helper do |p1|
    @p1 = p1
  end

  it "makes the helper method callable" do
    expect { example_helper }.to_not raise_error
  end

  it "adds the helper to the current scope" do
    example_helper("foo")

    expect(@p1).to eq("foo")
  end

  context "nested scope" do
    it "makes the helper available" do
      expect { example_helper("bar") }.to_not raise_error
      expect(@p1).to eq("bar")
    end
  end
end
