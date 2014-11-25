require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'domain/podcast'
require_relative 'services/stats_cache'
require_relative 'services/weekly_time'

class Pudget < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/timing' do
    url = params[:url]
    @dto = {
      :feed_url => url,
      :success => true
    }
    begin
      @dto[:time] = WeeklyTime.for get_stats(url)
    rescue Exception => e
      p e
      @dto[:success] = false
    end
    erb :search, :locals => { :dto => @dto }
  end

  def get_stats(url)
    stats = nil
    begin
      stats = StatsCache.for_podcast url
    rescue
      stats = FeedStats.for_url url
      StatsCache.save_stats(url, stats)
    end
    stats
  end
end

