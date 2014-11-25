require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'domain/podcast'
require_relative 'services/weekly_time'

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
    podcast = Podcast.fetch_rss url
    stats = FeedStats.for podcast
    @dto[:time] = WeeklyTime.for stats
  rescue
    @dto[:success] = false
  end
  erb :search, :locals => { :dto => @dto }
end

