require_relative '../spec_helper'
require_relative '../../app/domain/podcasts'

require 'vcr_helper'

describe Podcasts do
  it "can fetch opml from the Interwebs" do
    VCR.use_cassette("scottmuc-opml") do
      scottmuc_opml = 'http://scottmuc.com/podcasts_opml.xml'
      podcasts = Podcasts.fetch_opml scottmuc_opml
      expect(podcasts.count).to eq 1
      podcasts.all.each do |podcast|
        expect( podcast ).to be_kind_of(Podcast)
      end
    end
  end

  def stub_simple_rss(rss_hash)
    Hashie::Mash.new(rss_hash)
  end

  it "throws an INVALID_URL exception if the url is malformed" do
    expect {
      Podcasts.fetch_opml "some nonsense"
    }.to raise_exception(URI::InvalidURIError)
  end

  describe "#weekly_time" do
    it "sums the weekly times of all the podcasts" do
      simple_rss = stub_simple_rss({ :title => "Podcast Title", :items => [] })
      podcast = Podcast.new simple_rss
      allow(podcast).to receive(:weekly_time) { 30 }
      podcasts = Podcasts.from_podcasts [podcast, podcast]
      expect(podcasts.weekly_time).to eq 60
    end
  end
end

