require_relative './frank_sinatra/app'

module FrankSinatra
  module Proxy

    # create and start global app
    app = FrankSinatra::App.new
    at_exit { app.start }

    # create proxies for each FrankSinatra API method that execute on
    # global app
    [:get, :not_found].each do |api_method_name|
      define_method(api_method_name) do |*args, &block|
        app.send(api_method_name, *args, &block)
      end
    end
  end
end

# write proxy API methods onto main
extend FrankSinatra::Proxy
