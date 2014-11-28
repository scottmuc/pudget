
class WeeklyTime
  def self.for(podcast)
    weekly_cadence = 7 / podcast.release_cadence.to_f
    average_episode_length = podcast.average_episode_play_time
    (weekly_cadence * average_episode_length).to_i
  end

  def self.for_many(podcasts)
    podcasts.all.reduce(0) do |sum, podcast|
      sum = sum + WeeklyTime.for(podcast)
    end
  end
end

