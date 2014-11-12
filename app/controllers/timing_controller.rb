class TimingController < ApplicationController
  def index

  end

  def search
    feed_url = params[:url]
    @dto = { :feed_url => feed_url, :time => WeeklyTime.for(feed_url) }
  end
end
