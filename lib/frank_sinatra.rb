require_relative './frank_sinatra/app'

# proxy through top-level API calls to global app
def self.method_missing(method, *args, &block)
  if [:get].include?(method)
    @app.send(method, *args, &block)
  else
    super
  end
end

# create and start global app
@app = FrankSinatra::App.new
at_exit { @app.start }
