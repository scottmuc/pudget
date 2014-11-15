require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'services/rss_retriever'
require_relative 'services/weekly_time'

get '/' do
  erb :index
end

get '/timing' do
  url = params[:url]
  rss = RSSRetriever.fetch_rss url
  @dto = {
    :feed_url => url,
    :success => true
  }
  begin
    @dto[:time] = WeeklyTime.for rss
  rescue
    @dto[:success] = false
  end
  erb :search, :locals => { :dto => @dto }
end

