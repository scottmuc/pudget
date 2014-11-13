require 'simple-rss'
require 'open-uri'
require 'date'
require_relative 'duration'

class FeedStats
  def self.for(feed_url)
    rss = FeedRetriever.fetch_rss(feed_url)
    total_time = self.add_time(rss.items)
    average_time = total_time / rss.items.count
    release_cadence = self.release_cadence(rss.items)
    {
      :average_length => average_time,
      :podcast_name => rss.title,
      :total_time => total_time,
      :release_cadence => release_cadence,
    }
  end

  private

  class FeedRetriever
    def self.add_tag(tag)
      return if SimpleRSS.item_tags.include? tag
      SimpleRSS.item_tags << tag
    end

    def self.fetch_rss(url)
      self.add_tag :'itunes:duration'
      SimpleRSS.parse open(url)
    end
  end

  def self.add_time(items)
    items.inject(0) do |sum, item|
      sum + Duration.parse(item.itunes_duration).minutes
    end
  end

  def self.release_cadence(items)
    initial_date = DateTime.parse(items.last.pubDate.to_s)
    (DateTime.now - initial_date) / items.count
  end
end

