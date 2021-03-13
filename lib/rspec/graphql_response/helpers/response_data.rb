RSpec::GraphQLResponse.add_helper :response_data do |*fields|
  next nil unless response.is_a? Hash

  field_count = fields.compact.count
  response_data = response["data"]

  next response_data if field_count == 0

  dig_data = ->(data, field_index) do
    # dig through the array at the current field index
    return data.map { |v| dig_data.call(v, field_index) } if data.is_a? Array

    # it's not an array or hash, so exit
    return data unless data.is_a? Hash

    # it's a hash, so dig into the data
    field = fields[field_index]
    return data[field.to_s]
  end

  dig_deep = ->(data, field_index) do
    return data if field_index >= field_count

    result = dig_data.call(data, field_index)
    dig_deep.call(result, field_index + 1)
  end
    
  result = dig_deep.call(response_data, 0)
  Array(result).flatten
end
