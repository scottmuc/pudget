require 'simple-rss'
require 'open-uri'
require 'date'

class FeedStats
  def self.for(feed_url)
    rss = FeedRetriever.fetch_rss(feed_url)
    {
      :podcast_name => rss.title,
      :total_time => self.add_time(rss.items),
      :release_cadence => self.release_cadence(rss.items),
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
      sum + convert_to_seconds(item.itunes_duration)
    end
  end

  def self.release_cadence(items)
    initial_date = DateTime.parse(items.last.pubDate.to_s)
    (DateTime.now - initial_date) / items.count
  end

  def self.convert_to_seconds(duration_string)
    midnight = Time.parse('00:00:00')
    Time.parse(duration_string) - midnight
  end
end

