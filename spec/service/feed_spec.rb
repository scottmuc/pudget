require 'vcr'
require 'vcr_helper'
require_relative '../../app/services/feed'

describe Feed do
  it "returns the sum of all the episodes" do
    VCR.use_cassette("podcast-startup") do
      some_significant_number_of_seconds = 10000
      time = Feed.add_time 'http://feeds.hearstartup.com/hearstartup'
      expect(time).to be > some_significant_number_of_seconds
    end
  end
end
