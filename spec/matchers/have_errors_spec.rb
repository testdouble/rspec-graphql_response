RSpec.describe RSpec::GraphQLResponse::Matchers::HaveErrors do
  include described_class

  context "with errors" do
    let(:response) do 
      {
        "errors" => [{"message" => "No query string was present"}]
      }
    end

    it "validates errors" do
      expect(response).to have_errors
    end

    it "validates error count and message" do
      expect(response).to have_errors(1).with_messages("No query string was present")
    end
  end

  context "without errors" do
    let(:response) do 
      {}
    end

    it "validates no errors" do
      expect(response).to_not have_errors
    end

    it "validates no error count and or messages" do
      expect(response).to_not have_errors(1).with_messages("No query string was present")
    end
  end
end
