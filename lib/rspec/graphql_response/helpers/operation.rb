RSpec::GraphQLResponse.add_helper :operation do |name|
  warn 'WARNING: operation has been deprecated in favor of response_data. This helper will be removed in v0.5'
  return nil unless response.is_a? Hash

  response.dig("data", name.to_s)
end
