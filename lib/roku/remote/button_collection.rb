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
        build_top_row
        build_movement_row
        buttons.each do |key, button|
          button.paint
        end
      end

      def build_top_row
        buttons[:home] = Button.new('HOME', {
          left: '0%',
          top: '0%',
          width: '25%',
          height: '20%'
        }, 'esc')

        buttons[:info] = Button.new('INFO', {
          left: '50%',
          top: '0%',
          width: '25%',
          height: '20%'
        }, 'i')

        buttons[:back] = Button.new('BACK', {
          left: '75%',
          top: '20%',
          width: '25%',
          height: '20%'
        }, 'L')
      end

      def build_movement_row
        buttons[:left] = Button.new('LEFT ARROW', {
          left: '0%',
          top: '20%',
          width: '20%',
          height: '20%'
        }, 'h')

        buttons[:down] = Button.new('DOWN ARROW', {
          left: '20%',
          top: '20%',
          width: '20%',
          height: '20%'
        }, 'j')

        buttons[:up] = Button.new('UP ARROW', {
          left: '40%',
          top: '20%',
          width: '20%',
          height: '20%'
        }, 'k')

        buttons[:right] = Button.new('RIGHT ARROW', {
          left: '60%',
          top: '20%',
          width: '20%',
          height: '20%'
        }, 'l')

        buttons[:select] = Button.new('OK', {
          left: '80%',
          top: '20%',
          width: '20%',
          height: '20%'
        }, 'enter')
      end
    end
  end
end
