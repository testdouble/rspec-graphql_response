RSpec.describe RSpec::GraphQLResponse, "#add_context_helper", type: :graphql do
  RSpec::GraphQLResponse.add_context_helper :context_helper do |txt|
    self.define_method(:context_helper) { txt }
  end

  context_helper("foo")

  it "makes the helper available" do
    expect(context_helper).to eq("foo")
  end

  context "nested scope" do
    it "makes the helper available" do
      expect(context_helper).to eq("foo")
    end
  end
end
