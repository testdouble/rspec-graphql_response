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
        result = node[:operation].call(data, node[:key])

        dig_data(result, patterns.drop(1))
      end

      def parse_dig_pattern(*pattern)
        pattern_config = pattern.map do |pattern_item|
          {
            key: pattern_item.to_s,
            operation: self.method(:dig_symbol)
          }
        end
      end

      def dig_symbol(data, key)
        return data[key.to_s] if data.is_a? Hash

        if data.is_a? Array
          mapped_data = data.map { |value| value[key.to_s] }
          return mapped_data.flatten
        end

        return data
      end
    end
  end
end
