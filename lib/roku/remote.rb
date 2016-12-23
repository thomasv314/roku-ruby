require 'pry'
require 'curses'
require 'roku/device'
require 'roku/remote/button'
require 'roku/remote/button_collection'
require 'roku/remote/status_bar'
require 'roku/remote/device_scanner'

module Roku
  class Remote
    SEARCH_TEXT = 'Searching for devices... Press ESC to stop...'.freeze

    attr_reader :device

    def initialize
      Curses.curs_set(0)  # Invisible cursor
      Curses.noecho # do not show typed keys
      Curses.init_screen
    end

    def start
      @device = DeviceScanner.scan
      attach_device_to_status_bar
      scan_for_keypresses
    end

    def attach_device_to_status_bar
      status_bar.set_device(device)
    end

    def scan_for_keypresses
      loop do
        begin
          button_collection.paint
          keypressed = status_bar.getch
          status_bar.pressed(keypressed)
        rescue => ex
          Curses.close_screen
          raise ex
        end
      end
    end

    def status_bar
      @status_bar ||= StatusBar.new.paint
    end

    def button_collection
      @button_collection ||= ButtonCollection.new
    end

    def self.start
      Remote.new.start
    end
  end
end
