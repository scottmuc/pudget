require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'domain/podcast'
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
      podcast = Podcast.fetch_rss url
      p podcast
      @dto[:time] = WeeklyTime.for podcast
    rescue Exception => e
      p e
      @dto[:success] = false
    end
    erb :search, :locals => { :dto => @dto }
  end
end

