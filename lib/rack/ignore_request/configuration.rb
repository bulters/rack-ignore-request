module Rack
  class IgnoreRequest
    class << self
      attr_accessor :configuration
    end

    def self.configure
      yield(configuration)
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    class Configuration
      attr_accessor :ignore_path

      def initialize
        @ignore_path = '/monitor'
      end
    end
  end
end
