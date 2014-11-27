require 'opml-parser'
require 'open-uri'
require_relative 'podcast'

include OpmlParser

class Podcasts
  def self.fetch_opml(url)
    outlines = OpmlParser.import open(URI.parse url)
    Podcasts.new(outlines.drop 1)
  end

  def outline_to_podcast(outline)
    url = outline.attributes.fetch(:xmlUrl)
    Podcast.fetch_rss url
  end

  def initialize(outlines)
    @podcasts = outlines.map { |outline| outline_to_podcast outline }
  end

  def count
    @podcasts.count
  end

  def all
    @podcasts
  end
end

