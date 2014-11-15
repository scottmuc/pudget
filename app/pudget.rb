require 'sinatra'
require "sinatra/reloader" if development?
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
    @dto[:time] = WeeklyTime.for(url)
  rescue
    @dto[:success] = false
  end
  erb :search, :locals => { :dto => @dto }
end

