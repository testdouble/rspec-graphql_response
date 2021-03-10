RSpec.describe RSpec::GraphQLResponse, "#have_operation validator", type: :graphql do
  graphql_operation <<-GQL
    query CharacterList {
      characters {
        id
        name
      }
    }
  GQL

  let(:operation_name) { nil }

  subject(:result) do
    validator = RSpec::GraphQLResponse.validator :have_operation
    validator.validate_negated(response, operation_name: operation_name)
  end

  context "nil response" do
    let(:response) { nil }

    it "fails validation when response is nil" do
      expect(result.valid?).to be_falsey
    end

    it "provides a reason" do
      expect(result.reason).to eq("Cannot evaluate operations on nil")
    end
  end

  context "operation not present" do
    let(:operation_name) { :operation_does_not_exist }

    it "validates the operation result is not present" do
      expect(response).not_to have_errors
      expect(result.valid?).to be_truthy
    end
  end

  context "operation is found" do
    let(:operation_name) { :characters }

    it "fails validation" do
      expect(response).not_to have_errors
      expect(result.valid?).to be_falsey
    end

    it "provides a reason" do
      expect(result.reason).to eq("Expected not to find operation result named #{operation_name}, but found it\n\t#{response}")
    end
  end
end
