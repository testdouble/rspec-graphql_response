RSpec.describe RSpec::GraphQLResponse::Validators::HaveErrors do
  let(:expected_messages) { [] }

  let(:response) do 
    {
      "errors" => [{"message" => "No query string was present"}]
    }
  end

  let(:validation) do
    validator = described_class.new(response, expected_messages: expected_messages)
    validator.validate
  end

  it "validates" do
    expect(validation.valid?).to be_truthy
  end

  context "nil response" do
    let(:response) { }

    it "is invalid" do
      expect(validation.valid?).to be_falsey
      expect(validation.reason).to eq("Cannot evaluate nil for errors")
    end
  end

  context "no errors" do
    let(:response) { {} }

    it "is invalid" do
      expect(validation.valid?).to be_falsey
      expect(validation.reason).to eq("Expected response to have errors, but found none")
    end
  end

  context "correct message expected" do
    let(:expected_messages) { ["No query string was present"] }

    it "is valid" do
      expect(validation.valid?).to be_truthy
    end
  end

  context "too many expected messages" do
    let(:expected_messages) { ["No query string was present", "Error 2"] }
    
    it "is invalid" do
      expect(validation.valid?).to be_falsey
      expect(validation.reason).to eq("Expected\n\t[\"No query string was present\", \"Error 2\"]\nbut found\n\t[\"No query string was present\"]")
    end
  end

  context "incorrect message expected" do
    let(:expected_messages) { ["wrong error message"] }

    it "does not validate" do
      expect(validation.valid?).to be_falsey
    end

    it "provides a description of the problem" do
      expect(validation.reason).to eq("No query string was present")
    end
  end
end
