RSpec::GraphQLResponse.add_matcher :have_errors do |count = nil|
  match do |response|
    have_errors = RSpec::GraphQLResponse.validator(:have_errors)

    @result = have_errors.validate(
      response,
      expected_count: count,
      expected_messages: @messages
    )

    @result.valid?
  end

  failure_message do |_|
    @result.reason
  end

  match_when_negated do |response|
    have_errors = RSpec::GraphQLResponse.validator(:have_errors)

    @result = have_errors.validate_negated(
      response,
      expected_count: count,
      expected_messages: @messages
    )

    @result.valid?
  end

  failure_message_when_negated do |_|
    @result.reason
  end

  chain :with_messages do |*messages|
    @messages = messages
  end
end
