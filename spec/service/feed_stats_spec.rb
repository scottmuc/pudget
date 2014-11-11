require 'vcr'
require 'vcr_helper'
require_relative '../../app/services/feed_stats'

describe FeedStats do
  context "stats for Startup podcast" do
    let(:startup_podcast_feed) { 'http://feeds.hearstartup.com/hearstartup' }
    let(:stats) { FeedStats.for startup_podcast_feed }

    it "returns the total length of time of all the episodes" do
      VCR.use_cassette("podcast-startup") do
        some_significant_number_of_seconds = 10000
        expect(stats[:total_time]).to be > some_significant_number_of_seconds
      end
    end

    it "returns the release cadence in days" do
      VCR.use_cassette("podcast-startup") do
        expect(stats[:release_cadence]).to be > 5
      end
    end

    it "returns the title of the podcast" do
      VCR.use_cassette("podcast-startup") do
        expect(stats[:podcast_name]).to eq "StartUp Podcast"
      end
    end
  end
end
