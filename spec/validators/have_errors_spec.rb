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

  it "checks for errors with specific messages" do
    # expect(response).to have_errors.with_messages("No query string was present")
  end

  it "fails if error messages don't match" do
    # expect(response).to have_errors.with_messages("wrong error message")
  end

end
