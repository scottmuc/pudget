require_relative '../spec_helper'
require_relative '../../app/domain/podcasts'

require 'vcr_helper'

describe Podcasts do
  it "can fetch opml from the Interwebs" do
    VCR.use_cassette("scottmuc-opml") do
      scottmuc_opml = 'http://scottmuc.com/podcasts_opml.xml'
      podcasts = Podcasts.fetch_from_the_internet! scottmuc_opml
      expect(podcasts.count).to eq 1
      podcasts.each do |podcast|
        expect( podcast ).to be_kind_of(Podcast)
      end
    end
  end

  it "throws an INVALID_URL exception if the url is malformed" do
    expect {
      Podcasts.fetch_from_the_internet! "some nonsense"
    }.to raise_exception(URI::InvalidURIError)
  end
end

