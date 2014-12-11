require 'simple-rss'
require 'open-uri'

require_relative 'duration'
require_relative '../../lib/cache'

class Podcast
  def self.add_tag(tag)
    return if SimpleRSS.item_tags.include? tag
    SimpleRSS.item_tags << tag
  end

  def self.fetch_from_the_internet!(url)
    self.add_tag :'itunes:duration'
    unless Cache.has_key? url
      rss = SimpleRSS.parse open(URI.parse(url))
      Cache.store(url, self.create_from_simple_rss(rss))
    end
    Cache.fetch url
  end

  def self.create_from_simple_rss(simple_rss)
    title = simple_rss.title
    episodes = simple_rss.items.map do |rss_item|
      { :duration => Duration.parse(rss_item.itunes_duration),
        :title => rss_item.title,
        :publish_date => DateTime.parse(rss_item.pubDate.to_s)
      }
    end
    Podcast.new(title, episodes)
  end

  attr_reader :title, :episodes

  def initialize(title, episodes)
    @title = title
    @episodes = episodes
  end

  def episode_count
    @episodes.count
  end

  def age
    return 0 if episode_count == 0
    today = DateTime.now
    oldest = @episodes.min_by { |episode| episode[:publish_date] }
    (today - oldest[:publish_date]).to_i
  end

  def release_cadence
    return 0 if episode_count == 0
    age / episode_count
  end

  def total_play_time
    @episodes.inject(0) do |sum, episode|
      sum + episode[:duration].minutes
    end
  end

  def average_episode_play_time
    return 0 if episode_count == 0
    total_play_time / episode_count
  end

  def weekly_time
    return 0 if release_cadence == 0
    weekly_cadence = 7 / release_cadence.to_f
    average_episode_length = average_episode_play_time
    (weekly_cadence * average_episode_length).to_i
  end
end

