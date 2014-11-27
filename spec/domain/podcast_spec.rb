require_relative '../spec_helper'
require_relative '../../app/domain/podcast'

require 'vcr_helper'
require 'hashie/mash'

describe Podcast do
  context "loading from rss on the Interwebs" do
    it "can fetch podcast xml from the Interwebs" do
      VCR.use_cassette("podcast-startup") do
        startup_podcast_feed = 'http://feeds.hearstartup.com/hearstartup'
        podcast = Podcast.fetch_rss startup_podcast_feed
        expect(podcast.title).to eq "StartUp Podcast"
        expect(podcast.episode_count).to be > 0
        expect(podcast.episodes.first[:duration]).not_to be_nil
        expect(podcast.episodes.first[:publish_date]).not_to be_nil
      end
    end

    it "throws an INVALID_URL exception if the url is malformed" do
      expect {
        Podcast.fetch_rss("not a url")
      }.to raise_exception(URI::InvalidURIError)
    end
  end

  TODAY = DateTime.now.rfc822
  SIX_DAYS_AGO = (DateTime.now - 6).rfc822

  def stub_simple_rss(rss_hash)
    Hashie::Mash.new(rss_hash)
  end

  describe "#title" do
    it "maps to simples_rss title" do
      simple_rss = stub_simple_rss({ :title => "Podcast Title", :items => [] })
      podcast = Podcast.new simple_rss
      expect(podcast.title).to eq "Podcast Title"
    end
  end

  describe "#episodes" do
    it "maps to simple_rss items" do
      items = [ { :pubDate => TODAY, :itunes_duration => "" },
                { :pubDate => TODAY, :itunes_duration => "" }, ]
      simple_rss = stub_simple_rss({ :title => "Podcast Title", :items => items })
      podcast = Podcast.new simple_rss
      expect(podcast.episode_count).to eq 2
    end
  end

  describe "#age" do
    it "calculates the age of the podcast in days" do
      items = [ { :pubDate => TODAY, :itunes_duration => "" },
                { :pubDate => SIX_DAYS_AGO, :itunes_duration => "" }, ]
      simple_rss = stub_simple_rss({ :title => "Podcast Title", :items => items })
      podcast = Podcast.new simple_rss
      expect(podcast.age).to eq 6
    end

    it "calculates the age of the podcast in days in descending order" do
      items = [ { :pubDate => SIX_DAYS_AGO, :itunes_duration => "" },
                { :pubDate => TODAY, :itunes_duration => "" }, ]
      simple_rss = stub_simple_rss({ :title => "Podcast Title", :items => items })
      podcast = Podcast.new simple_rss
      expect(podcast.age).to eq 6
    end
  end

  describe "#release_cadence" do
    it "calculates the podcast's release cadence in days" do
      items = [ { :pubDate => SIX_DAYS_AGO, :itunes_duration => "" },
                { :pubDate => TODAY, :itunes_duration => "" }, ]
      simple_rss = stub_simple_rss({ :title => "Podcast Title", :items => items })
      podcast = Podcast.new simple_rss
      expect(podcast.release_cadence).to eq 3
    end
  end

  describe "#total_play_time" do
    it "calculates the total time for all episodes" do
      items = [ { :pubDate => TODAY, :itunes_duration => '00:10:00' },
                { :pubDate => TODAY, :itunes_duration => '01:00:00' }, ]
      simple_rss = stub_simple_rss({ :title => "Podcast Title", :items => items })
      podcast = Podcast.new simple_rss
      expect(podcast.total_play_time).to eq 70
    end
  end

  describe "#average_episode_play_time" do
    it "calculates the average episode play time" do
      items = [ { :pubDate => TODAY, :itunes_duration => '00:10:00' },
                { :pubDate => TODAY, :itunes_duration => '01:00:00' }, ]
      simple_rss = stub_simple_rss({ :title => "Podcast Title", :items => items })
      podcast = Podcast.new simple_rss
      expect(podcast.average_episode_play_time).to eq 35
    end
  end
end

