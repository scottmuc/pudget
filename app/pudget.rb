require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'domain/podcast'
require_relative 'domain/podcasts'


module Pudget
  class API
    def self.handle_url(&block)
      begin
        block.call
      rescue Exception => e
        { :success => false }
      end
    end

    def self.get_podcasts(opml, url)
      if opml == "on"
        handle_url do
          podcasts = Podcasts.fetch_opml url
          { :podcasts => podcasts }
        end
      else
        handle_url do
          podcast = Podcast.fetch_rss url
          podcasts = Podcasts.new [podcast]
          { :podcasts => podcasts}
        end
      end
    end
  end

  class App < Sinatra::Base
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

    end
  end
end

