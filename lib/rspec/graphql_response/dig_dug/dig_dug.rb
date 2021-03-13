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

        if node[:type] == :symbol
          result = dig_symbol(data, node[:key])
        elsif node[:type] == :array
          child_data = data[node[:key].to_s]
          result = dig_symbol(child_data, node[:value])
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
