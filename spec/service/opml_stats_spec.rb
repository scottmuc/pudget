require 'hashie/mash'
require_relative '../../app/services/opml_stats'

class FakeOutline
  attr_reader :attributes

  def initialize(url="")
    @attributes = { :xmlUrl => url }
  end
end

describe OPMLStats do
  it "returns the aggregate total time to listen to a collection of podcasts" do
    url = double
    feed_url = double
    expect(OPMLRetriever).to receive(:fetch_opml).with(url) {
      [ FakeOutline.new(feed_url) ]
    }
    expect(WeeklyTime).to receive(:for).with(feed_url) { 10 }
    stats = OPMLStats.for url
    expect(stats.count).to eq 1
  end
end
