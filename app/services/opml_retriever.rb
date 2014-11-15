require 'opml-parser'
require 'open-uri'

include OpmlParser

class OPMLRetriever
  def self.fetch_opml(url)
    outlines = OpmlParser.import open(URI.parse url)
    outlines.drop 1
  end
end

