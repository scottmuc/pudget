require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'api'

module Pudget
  class App < Sinatra::Base
    @@SESSION = {}

    get '/' do
      erb :index
    end

    def load_podcasts(params, importOpml = false)
      url = params[:url]
      id = params[:id]
      api_result = Pudget::API.get_podcasts(url, importOpml)
      @@SESSION[id].concat api_result.fetch(:podcasts)
      redirect "/pudget/#{id}"
    end

    post '/pudget/add/podcast' do
      load_podcasts(params)
    end

    post '/pudget/import' do
      load_podcasts(params, importOpml: true)
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

