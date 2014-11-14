require_relative 'opml_retriever'
require_relative 'weekly_time'

class OPMLStats
  def self.for(url)
    outlines = OPMLRetriever.fetch_opml url
    stats = []
    outlines.each do |outline|
      feed_url = outline.attributes[:xmlUrl]
      feed_stats = WeeklyTime.for feed_url
      stats << { :feed => feed_url, :weekly_time => feed_stats }
    end
    stats
  end
end

