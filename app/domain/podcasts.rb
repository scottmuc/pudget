require 'opml-parser'
require 'open-uri'
require_relative 'podcast'

include OpmlParser

class Podcasts
  def self.fetch_opml(url)
    outlines = OpmlParser.import open(URI.parse url)
    podcasts = outlines.drop(1).map { |outline| outline_to_podcast outline }
    Podcasts.new podcasts
  end

  def self.outline_to_podcast(outline)
    url = outline.attributes.fetch(:xmlUrl)
    Podcast.fetch_rss url
  end

  def initialize(podcasts)
    @podcasts = podcasts
  end

  def count
    @podcasts.count
  end

  def all
    @podcasts
  end

  def weekly_time
    @podcasts.reduce(0) do |sum, podcast|
      sum = sum + podcast.weekly_time
    end
  end
end

