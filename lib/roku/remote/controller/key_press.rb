module Roku
  class Remote
    class Controller
      class KeyPress
        ENTER = '10'.freeze
        ESCAPE_KEY = '27'.freeze
        BACKSPACE_KEY = '127'.freeze
        NUMBER_MAP = [*0..9].map do |number|
          [number.to_s, { name: "#{number} times", action: :num_times, number: number }]
        end.to_h.freeze

        CHAR_MAP = {
          'i' => { name: 'Info', action: :info },
          'h' => { name: 'Left Arrow', action: :left },
          'j' => { name: 'Down Arrow', action: :down },
          'l' => { name: 'Right Arrow', action: :right },
          'k' => { name: 'Up Arrow', action: :up },
          '/' => { name: 'Search', action: :search },
          'p' => { name: 'Power On', method: :power_on  },
          ENTER => { name: 'Enter', action: :select },
          ESCAPE_KEY  => { name: 'Home', action: :home },
          BACKSPACE_KEY => { name: 'Back', action: :back }
        }.merge(NUMBER_MAP).freeze

        attr_reader :key, :hash

        def initialize(akey, ahash)
          @key = akey
          @hash = ahash
          @name = hash[:name]
          @action = hash[:action]
        end

        def valid?
          hash.any?
        end

        def name
          hash[:name]
        end

        def action
          hash[:action]
        end

        def number
          hash[:number]
        end

        def method
          hash[:method]
        end

        def invalid_cmd
          "CMD Not Found: #{key}"
        end

        def is_numeric?
          return @num_map.include?(key) if defined?(@num_map)
          @num_map = [*0..9].map(&:to_s)
          @num_map.include?(key)
        end

        def is_esc?
          key.eql?(ESCAPE_KEY)
        end

        def self.find(key_press_str)
          press_hash = CHAR_MAP[key_press_str]
          if press_hash
            self.new(key_press_str, press_hash)
          else
            self.new(key_press_str, {})
          end
        end
      end
    end
  end
end
