require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'api'

module Pudget
  class App < Sinatra::Base
    @@SESSION = {}

    get '/' do
      erb :index
    end

    get '/timing' do
      url = params[:url]
      opml = params[:isOpml]
      api_result = Pudget::API.get_podcasts(opml, url)
      view_data = { :feed_url => url, :success => true }.merge! api_result
      erb :search, :locals => view_data
    end

    post '/pudget/create' do
      # TODO put unique id creation here
      redirect '/pudget/make_this_random'
    end

    get '/pudget/:id' do
      id = params[:id]
      erb :view, :locals => { :id => id }
    end
  end
end

