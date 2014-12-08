require 'opml-parser'
require 'open-uri'
require_relative 'podcast'

include OpmlParser

class Podcasts
  def self.fetch_from_the_internet!(url)
    outlines = OpmlParser.import open(URI.parse url)
    podcasts = outlines.drop(1).map { |outline| outline_to_podcast outline }
    podcasts
  end

  def self.outline_to_podcast(outline)
    url = outline.attributes.fetch(:xmlUrl)
    Podcast.fetch_from_the_internet! url
  end
end

