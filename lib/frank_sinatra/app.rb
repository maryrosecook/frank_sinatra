require 'rack'
require 'pp'

module FrankSinatra
  class App
    def initialize
      @routes = []
      @_404_block = Proc.new do
        Rack::Response.new(["Not found"], 404, {'Content-Type' => 'text/html'})
      end
    end

    def get(path, &route_block)
      puts path
      puts route_block
      add_route(:GET, path, route_block)
    end

    def not_found(&block)
      @_404_block = block
    end

    def add_route(method, path, route_block)
      @routes << Route.new(method, path, route_block)
    end

    def get_route_block(request)
      route = @routes.find do |route|
        route.matches?(request.request_method, request.path)
      end

      route ? route.block : @_404_block
    end

    def call(env)
      get_route_block(Rack::Request.new(env)).call
    end

    def start
      Rack::Handler::WEBrick.run(self)
    end
  end

  class Route
    attr_accessor :method, :path, :block

    def initialize(method, path, block)
      @method = method
      @path = path
      @block = block
    end

    def matches?(method, path)
      @method.to_s == method && @path == path
    end
  end
end
