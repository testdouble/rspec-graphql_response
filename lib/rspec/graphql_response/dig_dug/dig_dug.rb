module RSpec
  module GraphQLResponse
    class DigDug
      attr_reader :dig_pattern

      def initialize(dig_pattern)
        @dig_pattern = parse_dig_pattern(dig_pattern)
      end

      def dig(data)
        data[dig_pattern]
      end

      private

      def parse_dig_pattern(pattern)
        pattern[0].to_s
      end
    end
  end
end
