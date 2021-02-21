RSpec.describe RSpec::GraphQLResponse::Matchers, "have_errors" do
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

    it "invalidates with incorrect error count" do
      expect { 
        expect(response).to have_errors(2)
      }.to raise_error("Expected response to have 2 errors, but found 1")
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

    it "invalidates when expecting errors" do
      expect { 
        expect(response).to have_errors
      }.to raise_error("Expected response to have errors, but found none")
    end
  end
end
