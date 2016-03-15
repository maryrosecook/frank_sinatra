require_relative 'frank_sinatra'
require 'rack'

get "/" do
  [200, {}, ["hi"]]
end

not_found do
  Rack::Response.new(["Where is it??"], 404, {'Content-Type' => 'text/html'})
end
