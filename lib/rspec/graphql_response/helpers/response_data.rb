RSpec::GraphQLResponse.add_helper :response_data do |*fields|
  next nil unless response.is_a? Hash

  response_data = response["data"]
  next nil if response_data.nil?
  next nil if response_data.empty?

  fields = fields.compact
  next response_data if fields.empty?

  dig_dug = RSpec::GraphQLResponse::DigDug.new(*fields)
  dig_dug.dig(response_data)
end
