class WeeklyTime
  def self.for(podcast)
    weekly_cadence = 7 / podcast.release_cadence.to_f
    average_episode_length = podcast.average_episode_play_time
    (weekly_cadence * average_episode_length).to_i
  end
end

