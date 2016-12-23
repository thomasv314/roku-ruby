module Roku
  class Device
    class Response
      attr_reader :response

      def initialize(res)
        @response = res
      end

      def ok?
        response.success?
      end

      def struct_from_response_key(key)
        hash = response.parsed_response[key].map do |k, v|
          [k.to_sym, v]
        end.to_h
        Struct.new(*hash.keys).new(*hash.values)
      end
    end
  end
end
