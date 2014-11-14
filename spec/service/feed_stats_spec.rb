require 'date'
require 'vcr'
require 'vcr_helper'
require 'hashie/mash'
require_relative '../../lib/services/feed_stats'

describe FeedStats do
  TODAY = DateTime.now.rfc822
  SIX_DAYS_AGO = (DateTime.now - 6).rfc822

  let(:stats) { FeedStats.for "some stubbed out stream" }

  def stub_rss(rss_hash)
    expect(FeedRetriever).to receive(:fetch_rss) {
      Hashie::Mash.new(rss_hash)
    }
  end

  it "returns the total length of time of all the episodes" do
    items = [ { :pubDate => TODAY, :itunes_duration => '00:10:00' },
              { :pubDate => TODAY, :itunes_duration => '01:00:00' }, ]
    stub_rss({ :items => items})
    expect(stats[:total_time]).to eq 70
  end

  it "returns the release cadence in days" do
    items = [ { :pubDate => SIX_DAYS_AGO, :itunes_duration => '00:10:00' }, ]
    stub_rss({ :items => items})
    expect(stats[:release_cadence]).to eq 6
  end

  it "returns the title of the podcast" do
    # TODO items need to be populate because 0 items causes problems
    items = [ { :pubDate => SIX_DAYS_AGO, :itunes_duration => '00:10:00' }, ]
    stub_rss({ :title => "podcast title", :items => items})
    expect(stats[:podcast_name]).to eq "podcast title"
  end

  it "returns the average episode length" do
    items = [ { :pubDate => TODAY, :itunes_duration => '00:10:00' },
              { :pubDate => TODAY, :itunes_duration => '01:00:00' }, ]
    stub_rss({ :items => items})
    expect(stats[:average_length]).to eq 35
  end
end

