require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'domain/podcast'
require_relative 'domain/podcasts'

class Pudget < Sinatra::Base
  configure do
    enable :logging
  end

  get '/' do
    erb :index
  end

  def handle_url(&block)
    begin
      block.call
    rescue Exception => e
      logger.error e.inspect
      { :success => false }
    end
  end

  def get_podcasts(opml, url)
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

  get '/timing' do
    url = params[:url]
    opml = params[:isOpml]
    view_data = { :feed_url => url,
                  :success => true }.merge! get_podcasts(opml, url)
    erb :search, :locals => view_data
  end
end

