RSpec.describe RSpec::GraphQLResponse, "#add_validator" do
  before :all do
    RSpec::GraphQLResponse.add_validator :test_validator do
      failure_message :example, "example failure message"
      failure_message :does_not_pass, "does not pass"

      failure_message :negated_example, "example negated failure message"
      failure_message :negated_does_not_pass, "negated does not pass"

      validate do |actual, fail_example: false, fail_negated_example: false|
        next fail_validation(:example) if fail_example
        next fail_validation(:negated_example) if fail_negated_example

        actual = actual || {}
        it_passes = actual.fetch("pass", false)

        pass_validation
      end

      validate_negated do |actual, fail_example: false, fail_negated_example: false|
        next fail_validation(:example) unless fail_example
        next fail_validation(:negated_example) unless fail_negated_example

        actual = actual || {}
        it_passes = actual.fetch("pass", false)

        fail_validation(:negated_does_not_pass) if it_passes

        pass_validation
      end
    end
  end

  let(:fail_example) { false }
  let(:fail_negated_example) { false }
  let(:actual) { { pass: true } }

  describe "#validate" do
    subject(:result) do
      validator = RSpec::GraphQLResponse.validator(:test_validator)
      validator.validate(
        actual,
        fail_example: fail_example,
        fail_negated_example: fail_negated_example
      )
    end

    it "passes validation" do
      expect(result.valid?).to be_truthy
    end
  end

  after :all do
    RSpec::GraphQLResponse.remove_validator :test_validator
  end
end
