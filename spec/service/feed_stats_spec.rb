require 'vcr'
require 'vcr_helper'
require_relative '../../app/services/feed_stats'

describe FeedStats do
  context "stats for Startup podcast" do
    TWO_HOURS = 120
    TEN_MINUTES = 10
    FIVE_DAYS = 5

    let(:startup_podcast_feed) { 'http://feeds.hearstartup.com/hearstartup' }
    let(:stats) { FeedStats.for startup_podcast_feed }

    it "returns the total length of time of all the episodes" do
      VCR.use_cassette("podcast-startup") do
        expect(stats[:total_time]).to be > TWO_HOURS
      end
    end

    it "returns the release cadence in days" do
      VCR.use_cassette("podcast-startup") do
        some_reasonable_number_of_days = 5
        expect(stats[:release_cadence]).to be > FIVE_DAYS
      end
    end

    it "returns the title of the podcast" do
      VCR.use_cassette("podcast-startup") do
        expect(stats[:podcast_name]).to eq "StartUp Podcast"
      end
    end

    it "returns the average episode length" do
      VCR.use_cassette("podcast-startup") do
        expect(stats[:average_length]).to be > TEN_MINUTES
      end
    end
  end
end
