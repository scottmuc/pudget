require 'rack/test'
World(Rack::Test::Methods)

require_relative '../../app/pudget'

def app
  Pudget::App
end

