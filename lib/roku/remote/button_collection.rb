module Roku
  class Remote
    class ButtonCollection
      attr_reader :buttons

      def initialize
        build_buttons
      end

      def paint
      end

      def build_buttons
        @buttons = {}
        build_num_row
        build_power_row
        build_movement_row
        buttons.each do |key, button|
          button.paint
        end
      end

      def build_num_row
        [*0..9].each do |num|
          label = num + 1
          label = 0 if label == 10
          @buttons[num] = Button.new(label.to_s, {
              left: "#{num * 10}%",
              top: '0%',
              width: '10%',
              height: '10%'
          })
        end
      end

      def build_power_row
        buttons[:home] = Button.new('HOME', {
          left: '0%',
          top: '10%',
          width: '25%',
          height: '20%'
        }, 'esc')

        buttons[:on] = Button.new('ON', {
          left: '25%',
          top: '10%',
          width: '25%',
          height: '20%'
        }, 'P')

        buttons[:info] = Button.new('INFO', {
          left: '50%',
          top: '10%',
          width: '25%',
          height: '20%'
        }, 'i')

        buttons[:back_btn] = Button.new('BACK', {
          left: '75%',
          top: '10%',
          width: '25%',
          height: '20%'
        }, 'backspace')
      end

      def build_movement_row
        buttons[:left] = Button.new('LEFT ARROW', {
          left: '0%',
          top: '30%',
          width: '20%',
          height: '20%'
        }, 'h')

        buttons[:down] = Button.new('DOWN ARROW', {
          left: '20%',
          top: '30%',
          width: '20%',
          height: '20%'
        }, 'j')

        buttons[:up] = Button.new('UP ARROW', {
          left: '40%',
          top: '30%',
          width: '20%',
          height: '20%'
        }, 'k')

        buttons[:right] = Button.new('RIGHT ARROW', {
          left: '60%',
          top: '30%',
          width: '20%',
          height: '20%'
        }, 'l')

        buttons[:select] = Button.new('OK', {
          left: '80%',
          top: '30%',
          width: '20%',
          height: '20%'
        }, 'enter')
      end
    end
  end
end
