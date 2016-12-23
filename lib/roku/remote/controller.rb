require 'roku/remote/controller/key_press'

module Roku
  class Remote
    class Controller
      DEFAULT_MODE = :default.freeze
      TIMES_MODE = :times.freeze

      def initialize
        @repeat_action_times = nil
      end

      attr_accessor :device, :repeat_action_times

      def pressed(str)
        keypress = KeyPress.find(str.to_s)

        return keypress.invalid_cmd unless keypress.valid?
        return numeric_keypress_provided(keypress) if keypress.is_numeric?
        return reset_numeric(keypress) if keypress.is_esc? && repeat_action_times

        if repeat_action_times
          threads = []
          repeat_action_times.times do
            threads << Thread.new { device.press(keypress.action) }
          end
          threads.each(&:join)
          @repeat_action_times = nil
        else
          device.press(keypress.action)
        end

        return keypress.name
      end

      def numeric_keypress_provided(keypress)
        if repeat_action_times.nil?
          @repeat_action_times = keypress.number
        else
          @repeat_action_times = "#{@repeat_action_times.to_s}#{keypress.number.to_s}".to_i
        end
        "#{@repeat_action_times} TIMES"
      end

      def reset_numeric(keypress)
        str = "UNSET #{@repeat_action_times}"
        @repeat_action_times = 1
        str
      end

      def get_key_press(str)
        return @char_map[str] if defined? @char_map

        @char_map[str]
      end
    end
  end
end
