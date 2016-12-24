module Roku
  class Remote
    class Button # < Curses::Window
      attr_reader :text, :label, :top, :left, :height, :width, :window

      LABEL_RIGHT_BUFFER = 2

      def initialize(text_str, top_p, left_p, height_p, width_p, label_str = nil)
        @top = top_p
        @left = left_p
        @height = height_p
        @width = width_p
        @text = text_str
        @label = label_str
        @window = Curses::Window.new(top, left, height, width)
      end

      def paint
        window.clear
        window.resize(computed_height, computed_width)
        window.move(computed_top, computed_left)
        window.box(?|, ?-)

        window.setpos((computed_height/2)-1, (computed_width/2 - (text.size/2)))
        window.addstr(text)

        if label
          window.setpos(computed_height-2, computed_width- (label.length+LABEL_RIGHT_BUFFER))
          window.addstr(label)
        end

        window.refresh
      end

      def update_text(text_str)
        @text = text_str
        paint
      end

      def update_dimensions(hash)
        @top = hash[:top]
        @left = hash[:left]
        @height = hash[:height]
        @width = hash[:width]
      end

      def destroy
        window.clear
        window.refresh
        window.close
      end

      private

      def computed_height
        y_axis(height)
      end

      def computed_top
        y_axis(top)
      end

      def computed_left
        x_axis(left)
      end

      def computed_width
        x_axis(width)
      end

      def y_axis(percent_window_height)
        percent_window_height * Curses.lines / 100
      end

      def x_axis(percent_window_width)
        percent_window_width * Curses.cols / 100
      end
    end
  end
end
