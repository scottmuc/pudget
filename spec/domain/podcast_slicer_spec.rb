require_relative "../../app/domain/podcast_slicer"

describe PodcastSlicer do
  it "creates a slice of a podcast" do
    podcast = Podcast.new("Title", [])
    podcast_slice = PodcastSlicer.slice(podcast)
    expect( podcast_slice ).not_to be podcast
  end

  it "does not include episodes older than 4 weeks" do
    old_episode = { :publish_date => (DateTime.now - 4 * 7) }
    podcast = Podcast.new("Title", [old_episode])
    podcast_slice = PodcastSlicer.slice(podcast)
    expect( podcast_slice.episode_count ).to eq 0
  end

  it "includes episodes younger than 4 weeks" do
    new_episode = { :publish_date => DateTime.now }
    podcast = Podcast.new("Title", [new_episode])
    podcast_slice = PodcastSlicer.slice(podcast)
    expect( podcast_slice.episode_count ).to eq 1
  end
end

