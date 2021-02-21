RSpec::GraphQLResponse.add_validator :have_errors do
  failure_message :nil, "Cannot evaluate nil for errors"
  failure_message :none, "Expected response to have errors, but found none"
  failure_message :unmatched, ->(expected, actual) { "Expected\n\t#{expected.inspect}\nbut found\n\t#{actual.inspect}" }
  failure_message :length, ->(expected, actual) { "Expected response to have #{expected} errors, but found #{actual}" }

  failure_message_negated :nil, "Cannot evaluate nil for errors"
  failure_message_negated :none, ->(actual) { "Expected response not to have errors, but found\n\t#{actual.inspect}" }
  failure_message_negated :unmatched, ->(expected, actual) { "Expected not to find\n\t#{expected.inspect}\nbut found\n\t#{actual.inspect}" }
  failure_message_negated :length, ->(expected, actual) { "Expected response not to have #{expected} errors, but found #{actual}" }

  validate do |response, expected_messages: nil, expected_count: nil|
    next fail_validation(:nil) if response.nil?

    errors = response.fetch("errors", [])
    next fail_validation(:none, errors) if errors.length == 0

    with_messages = !expected_messages.nil?
    with_count = !expected_count.nil?

    if with_count
      actual_count = errors.length
      next fail_validation(:length, expected_count, actual_count) if expected_count != actual_count
    end

    if with_messages
      actual_messages = errors.map {|e| e["message"] }
      unmatched_messages = expected_messages.difference(actual_messages)

      next fail_validation(:unmatched, expected_messages, actual_messages) if unmatched_messages.any?
    end

    pass_validation 
  end
end
