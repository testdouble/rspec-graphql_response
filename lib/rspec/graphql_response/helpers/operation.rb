RSpec::GraphQLResponse.add_helper :operation do |name|
  return nil unless response.is_a? Hash

  response.dig("data", name.to_s)
end
