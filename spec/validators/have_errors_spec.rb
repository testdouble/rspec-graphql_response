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

  let(:actual_messages) do
    response.fetch("errors", []).map{ |e| e["message"] }
  end

  let(:actual_count) do
    response.fetch("errors", []).length
  end

  it "validates" do
    expect(have_errors.valid?).to be_truthy
  end

  context "nil response" do
    let(:response) { }

    it "is not valid" do
      expect(have_errors.valid?).to be_falsey
    end

    it "provides a reason" do
      expect(have_errors.reason).to eq("Cannot evaluate nil for errors")
    end

    it "provides a negated reason" do
      expect(have_errors.negated_reason).to eq("Cannot evaluate nil for errors")
    end
  end

  context "no errors" do
    let(:response) { {} }

    it "is not valid" do
      expect(have_errors.valid?).to be_falsey
    end

    it "provides a reason" do
      expect(have_errors.reason).to eq("Expected response to have errors, but found none")
    end

    it "provides a negated reason" do
      expect(have_errors.negated_reason).to eq("Expected response not to have errors, but found\n\t#{actual_messages.inspect}")
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
    
    it "is not valid" do
      expect(have_errors.valid?).to be_falsey
    end

    it "provides a reason" do
      expect(have_errors.reason).to eq("Expected\n\t#{expected_messages.inspect}\nbut found\n\t#{actual_messages.inspect}")
    end

    it "provides a negated reason" do
      expect(have_errors.negated_reason).to eq("Expected not to find\n\t#{expected_messages.inspect}\nbut found\n\t#{actual_messages.inspect}")
    end
  end

  context "incorrect message expected" do
    let(:expected_messages) { ["wrong error message"] }

    it "is not valid" do
      expect(have_errors.valid?).to be_falsey
    end

    it "provides a reason" do
      expect(have_errors.reason).to eq("Expected\n\t#{expected_messages.inspect}\nbut found\n\t#{actual_messages.inspect}")
    end

    it "provides a negated reason" do
      expect(have_errors.negated_reason).to eq("Expected not to find\n\t#{expected_messages.inspect}\nbut found\n\t#{actual_messages.inspect}")
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

    it "is not valid" do
      expect(have_errors.valid?).to be_falsey
    end

    it "provides a reason" do
      expect(have_errors.reason).to eq("Expected response to have #{expected_count} errors, but found #{actual_count}")
    end

    it "provides a negated reason" do
      expect(have_errors.negated_reason).to eq("Expected response not to have #{expected_count} errors, but found #{actual_count}")
    end
  end

  context "with unmatched error count and unmatched messages" do
    let(:expected_count) { 3 }
    let(:expected_messages) { ["No query string was present", "Error 2"] }

    it "is not valid" do
      expect(have_errors.valid?).to be_falsey
    end

    it "provides the unmatched error count reason" do
      expect(have_errors.reason).to eq("Expected response to have #{expected_count} errors, but found #{actual_count}")
    end

    it "provides the negated unmatched error count reason" do
      expect(have_errors.negated_reason).to eq("Expected response not to have #{expected_count} errors, but found #{actual_count}")
    end
  end

  context "with matched error count and unmatched messages" do
    let(:expected_count) { 1 }
    let(:expected_messages) { ["No query string was present", "Error 2"] }

    it "is not valid" do
      expect(have_errors.valid?).to be_falsey
    end

    it "provides the unmatched error count reason" do
      expect(have_errors.reason).to eq("Expected\n\t#{expected_messages.inspect}\nbut found\n\t#{actual_messages.inspect}")
    end

    it "provides the negated unmatched error count reason" do
      expect(have_errors.negated_reason).to eq("Expected not to find\n\t#{expected_messages.inspect}\nbut found\n\t#{actual_messages.inspect}")
    end
  end
end
