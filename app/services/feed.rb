require 'simple-rss'
require 'open-uri'

class Feed
  def self.add_tag(tag)
    return if SimpleRSS.item_tags.include? tag
    SimpleRSS.item_tags << tag
  end

  def self.add_time(feed_url)
    self.add_tag :'itunes:duration'
    rss = SimpleRSS.parse open(feed_url)
    rss.items.inject(0) { |sum, item| sum + convert_to_seconds(item.itunes_duration) }
  end

  def self.convert_to_seconds(duration_string)
    midnight = Time.parse('00:00:00')
    Time.parse(duration_string) - midnight
  end
end

