module RSpec
  module GraphQLResponse
    class DigDug
      attr_reader :dig_pattern

      def initialize(*dig_pattern)
        @dig_pattern = parse_dig_pattern(*dig_pattern)
      end

      def dig(data)
        dig_data(data, dig_pattern)
      end

      private

      def dig_data(data, patterns)
        return data if patterns.nil?
        return data if patterns.empty?

        node = patterns[0]
        node_key = node[:key]
        node_key = node_key.to_s if node_key.is_a? Symbol
        node_value = node[:value]

        if node[:type] == :symbol
          result = dig_symbol(data, node_key)
        elsif node[:type] == :array
          if data.is_a? Hash
            child_data = data[node_key]
            result = dig_symbol(child_data, node_value)
          elsif data.is_a? Array
            result = data.map { |value|
              child_data = value[node_key]
              dig_symbol(child_data, node_value)
            }.compact
          else
            result = data
          end
        end

        dig_data(result, patterns.drop(1))
      end

      def parse_dig_pattern(*pattern)
        pattern_config = pattern.map do |pattern_item|
          if pattern_item.is_a? Symbol 
            {
              type: :symbol,
              key: pattern_item
            }
          elsif pattern_item.is_a? Hash
            pattern_item.map do |key, value|
              {
                type: :array,
                key: key,
                value: value[0]
              }
            end
          end
        end

        pattern_config.flatten
      end

      def dig_symbol(data, key)
        key = key.to_s if key.is_a? Symbol
        return data[key] if data.is_a? Hash

        if data.is_a? Array
          if key.is_a? Numeric
            mapped_data = data[key]
          else
            mapped_data = data.map { |value| value[key] }.flatten
          end

          return mapped_data
        end

        return data
      end
    end
  end
end
