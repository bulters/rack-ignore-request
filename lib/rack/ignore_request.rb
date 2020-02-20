require 'rack/ignore_request/version'
require 'rack/ignore_request/configuration'

module Rack
  class IgnoreRequest
    def initialize(app)
      self.app = app
      @ignore_path = Rack::IgnoreRequest.configuration.ignore_path
    end

    def call(env)
      if env['PATH_INFO'] == @ignore_path
        [200, { 'Content-Type' => 'text/plain' }, ['OK']]
      else
        app.call(env)
      end
    end

    private

    attr_accessor :app
  end
end
