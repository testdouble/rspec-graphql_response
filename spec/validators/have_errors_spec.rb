RSpec.describe RSpec::GraphQLResponse::Validators::HaveErrors do
  let(:expected_messages) { [] }

  let(:response) do 
    {
      "errors" => [{"message" => "No query string was present"}]
    }
  end

  subject(:validate) do
    validator = described_class.new(response, expected_messages: expected_messages)
    validator.validate
  end

  it "validates when errors are present" do
    expect(validate).to be_truthy
  end

  context "correctly specified messages" do
    let(:expected_messages) { ["No query string was present"] }

    it "validates" do
      expect(validate).to be_truthy
    end
  end

  context "incorrectly specified messages" do
    let(:expected_messages) { ["wrong error message"] }

    it "does not validate when messages don't match" do
      expect(validate).to be_falsey
    end
  end
end
