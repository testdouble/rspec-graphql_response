RSpec::GraphQLResponse.add_helper :response_data do |*fields|
  return nil unless response.is_a? Hash

  response.dig(*([:data, *fields].compact).map {|field| field.to_s})
end
