module Roku
  class Remote
    class Button < Curses::Window
      attr_reader :dimensions, :text, :label

      LABEL_RIGHT_BUFFER = 2

      def initialize(text_str, dimension_hash, label_str = nil)
        @dimensions = dimension_hash
        @text = text_str
        @label = label_str
        compute_dimensions
        super(@height, @width, @top, @left)
      end

      def paint
        clear
        box(?|, ?-)
        setpos((@height/2)-1, (@width/2 - (text.size/2)))
        addstr(text)

        if label
          setpos(@height-2, @width-(label.length+LABEL_RIGHT_BUFFER))
          addstr(label)
        end
        refresh
        self
      end

      def update_text(text_str)
        @text = text_str
        paint
      end

      def compute_dimensions
        @dimensions = dimensions.map { |k,v| [k, v.gsub('%','').to_i] }.to_h
        top_percent = dimensions[:top]
        @top = top_percent * max_lines / 100
        height_percent = dimensions[:height]
        @height = height_percent * max_lines / 100
        left_percent = dimensions[:left]
        @left = left_percent * max_col / 100
        width_percent = dimensions[:width]
        @width = width_percent * max_col / 100
      end

      def max_lines
        Curses.lines
      end

      def max_col
        Curses.cols
      end
    end
  end
end
