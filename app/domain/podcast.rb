require 'simple-rss'
require 'open-uri'

require_relative 'duration'

class Podcast
  @@CACHE = {}

  def self.add_tag(tag)
    return if SimpleRSS.item_tags.include? tag
    SimpleRSS.item_tags << tag
  end

  def self.fetch_rss(url)
    self.add_tag :'itunes:duration'
    unless @@CACHE.has_key? url
      rss = SimpleRSS.parse open(URI.parse(url))
      self.memoize(url, Podcast.new(rss))
    end
    @@CACHE[url]
  end

  def self.memoize(url, podcast)
    @@CACHE[url] = podcast
  end

  attr_reader :title, :episodes

  def initialize(simple_rss)
    @title = simple_rss.title
    @episodes = simple_rss.items.map do |item|
      { :duration => Duration.parse(item.itunes_duration),
        :publish_date => DateTime.parse(item.pubDate.to_s)
      }
    end
  end

  def episode_count
    @episodes.count
  end

  def age
    today = DateTime.now
    oldest = episodes.min_by { |episode| episode[:publish_date] }
    (today - oldest[:publish_date]).to_i
  end

  def release_cadence
    age / episode_count
  end

  def total_play_time
    episodes.inject(0) do |sum, episode|
      sum + episode[:duration].minutes
    end
  end

  def average_episode_play_time
    total_play_time / episode_count
  end

  def weekly_time
    WeeklyTime.for self
  end
end

