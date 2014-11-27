require 'date'
require_relative '../domain/duration'

class FeedStats
  def self.for_url(url)
    self.for Podcast.fetch_rss(url)
  end

  private
  def self.for(podcast)
    total_time = self.add_time podcast.episodes
    average_time = total_time / podcast.episode_count
    release_cadence = self.release_cadence podcast.episodes
    {
      :average_length => average_time,
      :podcast_name => podcast.title,
      :total_time => total_time,
      :release_cadence => release_cadence,
    }
  end

  def self.add_time(episodes)
    episodes.inject(0) do |sum, episode|
      sum + Duration.parse(episode[:duration]).minutes
    end
  end

  def self.oldest_date(episodes)
    first = DateTime.parse(episodes.first[:publish_date].to_s)
    last  = DateTime.parse(episodes.last[:publish_date].to_s)
    [first, last].min
  end

  def self.release_cadence(episodes)
    initial_date = oldest_date episodes
    days = DateTime.now - initial_date
    number_of_episodes = episodes.count
    (days / number_of_episodes).to_i
  end
end

