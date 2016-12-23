module Roku
  class Remote
    class DeviceScanner
      def self.scan
        button = Button.new(SEARCH_TEXT, {
          left: '25%',
          top: '33%',
          height: '33%',
          width: '50%'
        }).paint

        device = false
        count = 0

        while !device
          device = Device.search_for_device
          count =+ 1
          button.update_text("#{SEARCH_TEXT} Attempts: #{count}")
        end

        button.update_text("Found Device!")
        sleep 1
        button.clear
        button.refresh
        button.close

        device
      end
    end
  end
end
