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

  def handle_opml(url)
    begin
      podcasts = Podcasts.fetch_opml url
      { :time => WeeklyTime.for_many(podcasts) }
    rescue Exception => e
      logger.error e.inspect
      { :success => false }
    end
  end

  def handle_rss(url)
    begin
      podcast = Podcast.fetch_rss url
      { :time => WeeklyTime.for(podcast) }
    rescue Exception => e
      logger.error e.inspect
      { :success => false }
    end
  end

  get '/timing' do
    url = params[:url]
    view_data = { :feed_url => url, :success => true }
    if params[:isOpml] == "on"
      view_data.merge!(handle_opml(url))
    else
      view_data.merge!(handle_rss(url))
    end
    erb :search, :locals => view_data
  end
end

