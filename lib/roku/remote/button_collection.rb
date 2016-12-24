require 'roku/remote/button_row'
require 'pry-remote'

module Roku
  class Remote
    class ButtonCollection
      attr_reader :buttons

      ROW_HEIGHT_DEFAULT = 20
      NUM_ROW_TOP = 0
      POWER_ROW_TOP = 20
      MOVE_ROW_TOP = 40

      def paint
        num_row.paint
        power_row.paint
        movement_row.paint
      end

      def num_row
        return @num_row if defined? @num_row
        @num_row = ButtonRow.new(NUM_ROW_TOP, ROW_HEIGHT_DEFAULT)
        [*0..9].each do |num|
          label = (num + 1).to_s
          @num_row.add(label.to_sym, label)
        end
        @num_row
      end

      def power_row
        return @power_row if defined? @power_row
        @power_row = ButtonRow.new(POWER_ROW_TOP, ROW_HEIGHT_DEFAULT)
        @power_row.add(:left, 'HOME', 'esc')
          .add(:on, 'ON', ?P)
          .add(:info, 'INFO', ?i)
          .add(:volume_down, 'VOL DOWN', ?-)
          .add(:volume_up, 'VOL UP', ?=)
          .add(:back_btn, 'BACK', 'backspace')
      end

      def movement_row
        return @movement_row if defined? @movement_row
        @movement_row = ButtonRow.new(MOVE_ROW_TOP, ROW_HEIGHT_DEFAULT)
        @movement_row.add(:left, 'LEFT ARROW', ?h)
          .add(:down, 'DOWN ARROW', ?j)
          .add(:up, 'UP ARROW', ?k)
          .add(:right, 'RIGHT ARROW', ?l)
          .add(:select, 'OK', 'enter')
      end
    end
  end
end
