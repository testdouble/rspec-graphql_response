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

  context "proc as value" do
    context_helper { "sample proc foo" }

    it "provides the proc" do
      expect(context_helper).to be_a Proc
      expect(context_helper.call).to eq("sample proc foo")
    end
  end
end
