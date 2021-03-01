RSpec.describe RSpec::GraphQLResponse, "#have_operation validator", type: :graphql do
  graphql_query <<-GQL
    query CharacterList {
      characters {
        id
        name
      }
    }
  GQL

  let(:operation_name) { "characters" }

  subject(:result) do
    validator = RSpec::GraphQLResponse.validator :have_operation
    validator.validate(response, operation_name: operation_name)
  end

  it "validates the operation result is present" do
    expect(result.valid?).to be_truthy
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

  context "operation not found" do
    let(:operation_name) { :operation_that_does_not_exist }

    it "fails validation when response is nil" do
      expect(result.valid?).to be_falsey
    end

    it "provides a reason" do
      expect(result.reason).to eq("Expected to find operation result named #{operation_name}, but did not find it\n\t#{response}")
    end
  end
end
