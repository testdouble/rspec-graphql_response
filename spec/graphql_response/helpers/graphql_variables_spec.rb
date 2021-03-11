RSpec.describe RSpec::GraphQLResponse, "graphql_variables helper", type: :graphql do
  graphql_operation <<-GQL
    query CharacterList($name: String) {
      characters(name: $name) {
        id
        name
      }
    }
  GQL

  graphql_variables({
    "name" => "Jam"
  })

  it "uses the supplied variables to execute the graphql query" do
    expect(response).to_not have_errors

    expect(response["data"]).to include(
      "characters" => [
        { "id" => "1", "name" => "Jam" },
      ]
    )
  end

  context "proc as value" do
    let(:sample_value) { "Pet" }

    graphql_variables do
      {
        name: sample_value
      }
    end

    it "provides access to let vars through a proc as value" do
      expect(response).to_not have_errors

      expect(response["data"]).to include(
        "characters" => [
          { "id" => "3", "name" => "Pet" }
        ]
      )
    end
  end
end
