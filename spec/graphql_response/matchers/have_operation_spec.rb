RSpec.describe RSpec::GraphQLResponse, "matcher#have_operation", type: :graphql do
  graphql_query <<-GQL
    query CharacterList {
      characters {
        id
        name
      }
    }
  GQL

  context "operation present" do
    it "is valid" do
      expect(response).to_not have_errors

      expect(response).to have_operation(:characters)
    end

    it "is invalid when negated" do
      expect(response).to_not have_errors

      expect { 
        expect(response).to_not have_operation(:characters)
      }.to raise_error(/Expected not to find operation result named characters/)
    end
  end

  context "operation not present" do
    it "is invalid" do
      expect(response).to_not have_errors

      expect {
        expect(response).to have_operation(:operation_not_present)
      }.to raise_error(/Expected to find operation result named operation_not_present/)
    end

    it "is valid when negated" do
      expect(response).to_not have_errors

      expect(response).to_not have_operation(:operation_not_present)
    end
  end
end
