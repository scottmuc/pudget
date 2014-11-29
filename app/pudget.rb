require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'domain/podcast'
require_relative 'domain/podcasts'
require_relative 'services/weekly_time'

class Pudget < Sinatra::Base
  configure do
    enable :logging
  end

  get '/' do
    erb :index
  end

  def handle_url(url, &block)
    begin
      block.call url
    rescue Exception => e
      logger.eror e.inspect
      { :success => false }
    end
  end

  get '/timing' do
    url = params[:url]
    view_data = { :feed_url => url, :success => true }
    if params[:isOpml] == "on"
      result = handle_url(url) do |url|
        podcasts = Podcasts.fetch_opml url
        { :time => WeeklyTime.for_many(podcasts) }
      end
      view_data.merge!(result)
    else
      result = handle_url(url) do |url|
        podcast = Podcast.fetch_rss url
        { :time => WeeklyTime.for(podcast) }
      end
      view_data.merge!(result)
    end
    erb :search, :locals => view_data
  end
end

