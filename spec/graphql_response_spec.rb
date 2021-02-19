RSpec.describe RSpec::GraphQLResponse, type: :graphql do
  let(:query) do
    <<~GQL
      query CharacterList {
        characters {
          id
          name
        }
      }
    GQL
  end

  before do
    described_class.configure do |config|
      config.graphql_schema = ExampleSchema
    end
  end

  it "has a version number" do
    expect(Rspec::GraphQLResponse::VERSION).not_to be nil
  end

  context "unhandled errors" do
    let(:query){ }

    context "no error count specified" do
      it "checks for unhandled errors" do
        expect(response).to have_errors
      end

      it "checks for errors with specific messages" do
        expect(response).to have_errors.with_messages("error 1")
      end

      it "allows more errors than specified" do
        expect(response).to have_errors.with_messages("error 2")
      end

      it "does not allow fewer errors than specified"
    end

    context "error count specified" do
      it "checks for the exact number of errors" do
        expect(response).to have_errors(1)
      end

      it "checks for a specified number of errors with an exact list of messages" do
        expect(response).to have_errors(2).with_messages("error 1", "error 2")
      end

      it "does not allow more errors than specified"
    end
  end

  context "no unhandled errors" do
    it "checks for no unhandled errors" do
      expect(response).to_not have_errors
    end
  end

  context "operations" do
    it "checks for an operation's response" do
      expect(response).to have_operation(:someThing)
    end

    it "checks for a non-existent operation response" do
      expect(response).to_not have_operation(:someThing)
    end
  end
end
