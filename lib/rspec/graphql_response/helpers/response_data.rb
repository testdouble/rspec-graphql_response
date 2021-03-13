RSpec::GraphQLResponse.add_helper :response_data do |*fields|
  next nil unless response.is_a? Hash

  response_data = response["data"]
  next response_data if fields.compact.count == 0

  # must pre-declare these to make the references valid by lexical scope
  dig_deep = nil
  dig_data = nil

  # dig the value of field (as field_list[field_index]) out of data
  dig_data = ->(data, field_index, field_list) do
    field = field_list[field_index]

    # handle `characters: [1]` for arrays of values
    # handle `characters: [:friends]` for a hash within arrays
    if field.is_a? Hash
      hash_keys = field.keys
      first_key = hash_keys[0]
      data_value = data[first_key.to_s]
      data = dig_deep.call(data_value, 1, hash_keys)
      return data
    end

    # dig through the array at the current field index
    return data.map { |v| dig_data.call(v, field_index, field_list) } if data.is_a? Array

    # it's not an array or hash, so exit
    return data unless data.is_a? Hash

    # it's a hash, so dig into the data
    return data[field.to_s]
  end

  dig_deep = ->(data, field_index, field_list) do
    field_count = field_list.count
    return data if field_index >= field_count

    result = dig_data.call(data, field_index, field_list)
    dig_deep.call(result, field_index + 1, field_list)
  end
    
  result = dig_deep.call(response_data, 0, fields.compact)
  Array(result).flatten
end
