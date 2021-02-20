RSpec.describe RSpec::GraphQLResponse::Validators::HaveErrors do
  let(:expected_messages) { [] }
  let(:expected_count) { nil }

  let(:response) do 
    {
      "errors" => [{"message" => "No query string was present"}]
    }
  end

  let(:have_errors) do
    validator = described_class.new(
      response,
      expected_messages: expected_messages,
      expected_count: expected_count,
    )

    validator.validate
  end

  it "validates" do
    expect(have_errors.valid?).to be_truthy
  end

  context "nil response" do
    let(:response) { }

    it "is invalid" do
      expect(have_errors.valid?).to be_falsey
      expect(have_errors.reason).to eq("Cannot evaluate nil for errors")
    end
  end

  context "no errors" do
    let(:response) { {} }

    it "is invalid" do
      expect(have_errors.valid?).to be_falsey
      expect(have_errors.reason).to eq("Expected response to have errors, but found none")
    end
  end

  context "correct message expected" do
    let(:expected_messages) { ["No query string was present"] }

    it "is valid" do
      expect(have_errors.valid?).to be_truthy
    end
  end

  context "too many expected messages" do
    let(:expected_messages) { ["No query string was present", "Error 2"] }
    
    it "is invalid" do
      expect(have_errors.valid?).to be_falsey
    end

    it "provides a reason" do
      expect(have_errors.reason).to eq("Expected\n\t[\"No query string was present\", \"Error 2\"]\nbut found\n\t[\"No query string was present\"]")
    end
  end

  context "incorrect message expected" do
    let(:expected_messages) { ["wrong error message"] }

    it "is not valid" do
      expect(have_errors.valid?).to be_falsey
    end

    it "provides a reason" do
      expect(have_errors.reason).to eq("Expected\n\t[\"wrong error message\"]\nbut found\n\t[\"No query string was present\"]")
    end
  end

  context "with expected error count matching actual error count" do
    let(:expected_count) { 1 }

    it "is valid" do
      expect(have_errors.valid?).to be_truthy
    end
  end

  context "with expected error count not matching actual error count" do
    let(:expected_count) { 2 }

    it "is invalid" do
      expect(have_errors.valid?).to be_falsey
    end

    it "provides a reason" do
      expect(have_errors.reason).to eq("Expected response to have #{expected_count} errors, but found 1")
    end
  end

  context "with unmatched error count and unmatched messages" do
    let(:expected_count) { 3 }
    let(:expected_messages) { ["No query string was present", "Error 2"] }

    it "is invalid" do
      expect(have_errors.valid?).to be_falsey
    end

    it "provides the unmatched error count reason" do
      expect(have_errors.reason).to eq("Expected response to have #{expected_count} errors, but found 1")
    end
  end

  context "with matched error count and unmatched messages" do
    let(:expected_count) { 1 }
    let(:expected_messages) { ["No query string was present", "Error 2"] }

    it "is invalid" do
      expect(have_errors.valid?).to be_falsey
    end

    it "provides the unmatched error count reason" do
      expect(have_errors.reason).to eq("Expected\n\t[\"No query string was present\", \"Error 2\"]\nbut found\n\t[\"No query string was present\"]")
    end
  end
end
