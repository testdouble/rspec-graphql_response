require "rspec/graphql_response/matchers/have_errors"

RSpec.describe RSpec::GraphQLResponse::Matchers::HaveErrors do
  include described_class

  let(:expected_messages) { [] }

  let(:response) do 
    {
      "errors" => [{"message" => "No query string was present"}]
    }
  end

  context "unhandled errors" do
    context "no error count specified" do
      it "checks for unhandled errors" do
        expect(response).to have_errors
      end

      it "checks for errors with specific messages" do
        expect(response).to have_errors.with_messages("No query string was present")
      end

      it "fails if error messages don't match" do
        expect(response).to have_errors.with_messages("wrong error message")
      end
    end
  end
end
