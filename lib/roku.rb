require 'roku/device'
require 'roku/remote'

module Roku
  VERSION = '0.1.0'.freeze
  class << self
    def log
      return @logger if defined? @logger
      require 'logger'
      @logger = Logger.new('debug.log')
    end
  end
end
