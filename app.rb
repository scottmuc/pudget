require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'lib/services/weekly_time'

get '/' do
  erb :index
end

get '/timing' do
  url = params[:url]
  @dto = { :feed_url => url, :time => WeeklyTime.for(url) }
  erb :search, :locals => { :dto => @dto }
end

