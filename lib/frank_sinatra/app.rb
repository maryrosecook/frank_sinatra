require 'rack'

module FrankSinatra
  class App
    def initialize
      @routes = []
    end

    def get(path, &route_block)
      @routes << Route.new(:GET, path, route_block)
    end

    def call(env)
      method = env["REQUEST_METHOD"]
      path = env["REQUEST_PATH"]
      route = @routes.find { |route| route.matches?(method, path) }

      if route
        route.block.call
      else
        [404, {'Content-Type' => 'text/html'}, ["Not found"]]
      end
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
