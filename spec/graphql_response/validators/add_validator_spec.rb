RSpec.describe RSpec::GraphQLResponse, "#add_validator" do
  before :all do
    RSpec::GraphQLResponse.add_validator :test_validator do
      # validation messages and method
      # ------------------------------

      failure_message :example, "example failure message"
      failure_message :does_not_pass, "does not pass"

      validate do |actual, fail_example: false|
        next fail_validation(:example) if fail_example

        actual = actual || {}
        it_passes = actual.fetch("pass", false)
        next fail_validation(:does_not_pass) unless it_passes

        pass_validation
      end

      # negated validation messages and method
      # --------------------------------------

      failure_message :negated_example, "example negated failure message"
      failure_message :negated_does_not_pass, "negated does not pass"

      validate_negated do |actual, fail_negated_example: false|
        next fail_validation(:negated_example) if fail_negated_example

        actual = actual || {}
        it_passes = actual.fetch("pass", false)
        next fail_validation(:negated_does_not_pass) if it_passes

        pass_validation
      end
    end
  end

  let(:validator) do
    RSpec::GraphQLResponse.validator(:test_validator)
  end

  describe "#validate" do
    let(:fail_example) { false }

    let(:actual) do
      { "pass" => true }
    end

    subject(:result) do
      validator.validate(actual, fail_example: fail_example)
    end

    context "passes" do
      it "passes validation" do
        expect(result.valid?).to be_truthy
      end

      it "does not provide a reason" do
        expect(result.reason).to be_nil
      end
    end

    context "does not pass" do
      let(:actual) do
        { pass: false }
      end

      it "fails validation" do
        expect(result.valid?).to be_falsey
      end

      it "provides a reason" do
        expect(result.reason).to eq("does not pass")
      end
    end

    context "fails example" do
      let(:fail_example) { true }

      it "does not pass validation" do
        expect(result.valid?).to be_falsey
      end

      it "provides a reason" do
        expect(result.reason).to eq("example failure message")
      end
    end
  end

  describe "#validate_negated" do
    let(:fail_negated_example) { false }

    let(:actual) do
      { pass: false }
    end

    subject(:result) do
      validator.validate_negated(actual, fail_negated_example: fail_negated_example)
    end

    context "negated pass" do
      it "passes negated validation" do
        expect(result.valid?).to be_truthy
      end

      it "does not provide a reason" do
        expect(result.reason).to be_nil
      end
    end

    context "fail negated example" do
      let(:fail_negated_example) { true }

      it "does not validate" do
        expect(result.valid?).to be_falsey
      end

      it "provides a reason" do
        expect(result.reason).to eq("example negated failure message")
      end
    end
  end

  after :all do
    RSpec::GraphQLResponse.remove_validator :test_validator
  end
end
