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
      field.each do |key, value|
        data_value = data[key.to_s]

        value = value[0]
        value = value.to_s if value.is_a? Symbol

        data_value = data_value.map {|h| h[value]} if value.is_a? String
        data_value = data_value[value] if value.is_a? Numeric
        data = data_value
      end

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
    return data if field_list.nil?

    field_count = field_list.count
    return data if field_index >= field_count

    result = dig_data.call(data, field_index, field_list)
    dig_deep.call(result, field_index + 1, field_list)
  end
    
  result = dig_deep.call(response_data, 0, fields.compact)
  result = result.flatten if result.is_a? Array
  result
end
