RSpec::GraphQLResponse.add_matcher :have_errors do |count = nil|
  match do |response|
    have_errors = RSpec::GraphQLResponse::Validators::HaveErrors.new(
      response,
      expected_count: count,
      expected_messages: @messages
    )

    @result = have_errors.validate
    @result.valid?
  end

  failure_message do |response|
    @result.reason
  end

  failure_message_when_negated do |response|
    @result.negated_reason
  end

  chain :with_messages do |*messages|
    @messages = messages
  end
end
