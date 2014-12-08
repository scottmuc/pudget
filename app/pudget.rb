require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'api'

module Pudget
  class App < Sinatra::Base
    @@SESSION = {}

    get '/' do
      erb :index
    end

    post '/podcast/add' do
      url = params[:url]
      id = params[:id]
      api_result = Pudget::API.get_podcasts("off", url)
      @@SESSION[id] = api_result.fetch(:podcasts)
      redirect '/pudget/make_this_random'
    end

    post '/pudget/create' do
      # TODO put unique id creation here
      redirect '/pudget/make_this_random'
    end

    get '/pudget/:id' do
      id = params[:id]
      podcasts = @@SESSION.fetch(id, [])
      erb :view, :locals => { :id => id, :podcasts => podcasts }
    end
  end
end

