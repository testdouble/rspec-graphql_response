RSpec.describe RSpec::GraphQLResponse::Matchers::HaveErrors do
  include described_class

  context "with errors" do
    let(:response) do 
      {
        "errors" => [{"message" => "No query string was present"}]
      }
    end

    it "checks for errors" do
      expect(response).to have_errors
    end
  end

  context "with errors" do
    let(:response) do 
      {}
    end

    it "checks for no errors" do
      expect(response).to_not have_errors
    end
  end
end
