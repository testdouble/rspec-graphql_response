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

  it "validates when errors are present" do
    expect(validation.valid?).to be_truthy
  end

  context "correctly specified messages" do
    let(:expected_messages) { ["No query string was present"] }

    it "validates" do
      expect(validation.valid?).to be_truthy
    end
  end

  context "incorrectly specified messages" do
    let(:expected_messages) { ["wrong error message"] }

    it "does not validate" do
      expect(validation.valid?).to be_falsey
    end

    it "provides a description of the problem" do
      expect(validation.errors).to include(
        "No query string was present"
      )
    end
  end
end
