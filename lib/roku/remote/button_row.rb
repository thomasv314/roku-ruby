module Roku
  class Remote
    class ButtonRow
      EMPTY_DIMENSIONS = { left: 0, top: 0, width: 0, height: 0 }.freeze

      attr_reader :buttons, :top, :height

      def initialize(top_percent, height_percent)
        @buttons = {}
        @top = top_percent
        @height = height_percent
      end

      def paint
        buttons.values.each(&:paint)
      end

      def add(id, name, key_label = nil)
        buttons[id] = Button.new(name, top, 0, height, 0, key_label)
        buttons.values.each_with_index do |button, i|
          button.update_dimensions(left: computed_left(i), top: top,
                                   height: height, width: computed_width)
        end
        self
      end

      private

      def computed_left(idx = 0)
        idx * computed_width
      end

      def computed_width
        100 / buttons.count
      end

    end
  end
end
