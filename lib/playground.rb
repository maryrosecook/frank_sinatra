require_relative 'frank_sinatra'

get "/" do
  [200, {}, ["hi"]]
end
