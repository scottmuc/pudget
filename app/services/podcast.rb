require 'simple-rss'
require 'open-uri'

class Podcast
  def self.add_tag(tag)
    return if SimpleRSS.item_tags.include? tag
    SimpleRSS.item_tags << tag
  end

  def self.fetch_rss(url)
    self.add_tag :'itunes:duration'
    SimpleRSS.parse open(URI.parse(url))
  end
end

