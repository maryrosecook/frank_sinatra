module FrankSinatra
  class App
    def initialize()
      @routes = []
    end

    def get(url, &block)
      @routes << Route.new(url, :get, block)
    end
  end

  class Route
    attr_accessor :url, :method, :block

    def initialize(url, method, block)
      @url = url
      @method = method
      @block = block
    end
  end
end
