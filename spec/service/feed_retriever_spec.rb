require_relative '../../lib/services/feed_retriever'

describe FeedRetriever do
  it "can fetch podcast xml from the Interwebs" do
    VCR.use_cassette("podcast-startup") do
      startup_podcast_feed = 'http://feeds.hearstartup.com/hearstartup'
      rss = FeedRetriever.fetch_rss startup_podcast_feed
      expect(rss.title).to eq "StartUp Podcast"
      expect(rss.items.count).to be > 0
      expect(rss.items.first.itunes_duration).not_to be_nil
    end
  end

  it "throws an INVALID_URL exception if the url is malformed" do
    expect {
      FeedRetriever.fetch_rss("not a url")
    }.to raise_exception(URI::InvalidURIError)
  end
end

