require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'domain/podcast'
require_relative 'domain/podcasts'
require_relative 'services/weekly_time'

class Pudget < Sinatra::Base
  configure {
    enable :logging
  }

  get '/' do
    erb :index
  end

  get '/timing' do
    url = params[:url]
    isOpml = params[:isOpml]
    logger.info "isOpml = #{isOpml}"

    @dto = {
      :feed_url => url,
      :success => true
    }
    begin
      if isOpml == "on"
        podcasts = Podcasts.fetch_opml url
        @dto[:time] = podcasts.all.reduce(0) do |sum, podcast|
          sum = sum + WeeklyTime.for(podcast)
        end
      else
        podcast = Podcast.fetch_rss url
        @dto[:time] = WeeklyTime.for podcast
      end
    rescue Exception => e
      p e
      @dto[:success] = false
    end
    erb :search, :locals => { :dto => @dto }
  end
end

