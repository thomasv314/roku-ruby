require 'roku/remote/controller'

module Roku
  class Remote
    class StatusBar < Button
      WIDTH = '100%'.freeze
      HEIGHT = '10%'.freeze
      TOP = '90%'.freeze
      LEFT = '0%'.freeze

      attr_reader :controller

      def initialize
        @controller = Controller.new
        @text = 'status: waiting for command'
        @dimensions =  {
          width: WIDTH,
          height: HEIGHT,
          top: TOP,
          left: LEFT
        }
        super(@text, @dimensions)
      end

      def set_device(device)
        controller.device= device
      end

      def pressed(press)
        @text = controller.pressed(press)
        paint
      end
    end
  end
end
