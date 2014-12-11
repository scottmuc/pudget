class PodcastSlicer
  def self.slice(podcast)
    episodes = podcast.episodes.select do |episode|
      episode.fetch(:publish_date) > (DateTime.now - 4 * 7)
    end
    Podcast.new(podcast.title, episodes)
  end
end

