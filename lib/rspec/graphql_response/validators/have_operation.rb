RSpec::GraphQLResponse.add_validator :have_operation do
  failure_message :nil, "Cannot evaluate operations on nil"
  failure_message :not_found, ->(expected, actual) { "Expected to find operation result named #{expected}, but did not find it\n\t#{actual}" }

  validate do |response, operation_name:|
    next fail_validation(:nil) unless response.is_a? Hash

    op = response.dig("data", operation_name)
    next fail_validation(:not_found, operation_name, response) if op.nil?

    pass_validation
  end
end
