require 'vcr'
require 'vcr_helper'
require_relative '../../app/services/feed_stats'

describe FeedStats do

  let(:startup_podcast_feed) { 'http://feeds.hearstartup.com/hearstartup' }

  it "returns the sum of all the episodes" do
    VCR.use_cassette("podcast-startup") do
      some_significant_number_of_seconds = 10000
      time = FeedStats.add_time startup_podcast_feed
      expect(time).to be > some_significant_number_of_seconds
    end
  end

  it "returns the release cadence in days" do
    VCR.use_cassette("podcast-startup") do
      cadence = FeedStats.release_cadance startup_podcast_feed
      expect(cadence).to be > 5
    end
  end
end
