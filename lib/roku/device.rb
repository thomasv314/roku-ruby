require 'ssdp'
require 'httparty'
require 'roku/device/response'

module Roku
  class Device
    include HTTParty

    class CannotGetInfo < StandardError; end

    ROKU = 'roku:ecp'.freeze

    ACTIONS = {
      home: 'Home',
      reverse: 'Rev',
      forward: 'Fwd',
      play: 'Play',
      select: 'Select',
      left: 'Left',
      right: 'Right',
      down: 'Down',
      up: 'Up',
      back: 'Back',
      replay: 'InstantReplay',
      info: 'Info',
      del: 'Backspace',
      search: 'Search',
      enter: 'Enter',
      volume_up: 'VolumeUp',
      volume_down: 'VolumeDown',
      volume_mute: 'VolumeMute'
    }.freeze

    attr_reader :location, :boot_info

    def initialize(loc)
      @location = loc
      self.class.base_uri(location.to_s)
      @boot_info = info
    end

    def power_on
      Response.new(self.class.post('/launch/tvinput.hdm1'))
    end

    def info
      res = Response.new(self.class.get('/query/device-info'))
      raise CannotGetInfo unless res.ok?
      res.struct_from_response_key('device_info')
    end

    def press(keypress)
      if keypress.action
        Response.new(self.class.post("/keypress/#{ACTIONS[keypress.action]}"))
      elsif keypress.method
        send(keypress.method)
      else
        raise ArgumentError, "UnsureWhatThatKeyPressIs"
      end
    end

    def self.search_for_device
      finder = SSDP::Consumer.new(timeout: 3, first_only: true)
      result = finder.search(service: ROKU)
      if result
        Device.new(
          URI.parse(result[:params]['LOCATION'])
        )
      else
        puts 'Cannot find a roku device..'
        false
      end
    end
  end
end
