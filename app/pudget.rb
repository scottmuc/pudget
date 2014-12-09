require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'api'

module Pudget
  class App < Sinatra::Base
    @@SESSION = {}

    get '/' do
      erb :index
    end

    post '/pudget/add/podcast' do
      url = params[:url]
      id = params[:id]
      api_result = Pudget::API.get_podcasts("off", url)
      @@SESSION[id].concat api_result.fetch(:podcasts)
      redirect "/pudget/#{id}"
    end

    post '/pudget/import' do
      url = params[:url]
      id = params[:id]
      api_result = Pudget::API.get_podcasts("on", url)
      @@SESSION[id].concat api_result.fetch(:podcasts)
      redirect "/pudget/#{id}"
    end

    post '/pudget/create' do
      unique_id = SecureRandom::uuid
      @@SESSION[unique_id] = []
      redirect "/pudget/#{unique_id}"
    end

    get '/pudget/:id' do
      id = params[:id]
      podcasts = @@SESSION.fetch id
      erb :view, :locals => { :id => id, :podcasts => podcasts }
    end
  end
end

