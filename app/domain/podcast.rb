require 'simple-rss'
require 'open-uri'

class Podcast
  def self.add_tag(tag)
    return if SimpleRSS.item_tags.include? tag
    SimpleRSS.item_tags << tag
  end

  def self.fetch_rss(url)
    self.add_tag :'itunes:duration'
    rss = SimpleRSS.parse open(URI.parse(url))
    Podcast.new rss
  end

  attr_reader :title, :episodes

  def initialize(simple_rss)
    @title = simple_rss.title
    @episodes = simple_rss.items.map do |item|
      { :duration => item.itunes_duration,
        :publish_date => item.pubDate }
    end
  end

  def episode_count
    @episodes.count
  end
end

