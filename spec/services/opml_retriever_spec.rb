require 'vcr_helper'
require_relative '../../app/services/opml_retriever'

describe OPMLRetriever do
  it "can fetch opml from the Interwebs" do
    VCR.use_cassette("random-opml") do
      feed = 'http://scottmuc.com/podcasts_opml.xml'
      outlines = OPMLRetriever.fetch_opml feed
      expect(outlines.count).to be > 0
      expect(outlines.first.attributes[:xmlUrl]).not_to be_nil
    end
  end

  it "throws an INVALID_URL exception if the url is malformed" do
    expect {
      OPMLRetriever.fetch_opml "some nonsense"
    }.to raise_exception(URI::InvalidURIError)
  end
end

