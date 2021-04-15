RSpec::GraphQLResponse.add_matcher :have_field do |operation_name|
  match do |response|
    validator = RSpec::GraphQLResponse.validator(:have_field)

    @result = validator.validate(response, operation_name: operation_name)
    @result.valid?
  end

  failure_message do |_|
    @result.reason
  end

  match_when_negated do |response|
    validator = RSpec::GraphQLResponse.validator(:have_field)

    @result = validator.validate_negated(response, operation_name: operation_name)
    @result.valid?
  end

  failure_message_when_negated do |_|
    @result.reason
  end
end
