require_relative 'feed_stats'

class WeeklyTime
  def self.for(stats)
    weekly_cadence = 7 / stats.fetch(:release_cadence).to_f
    average_episode_length = stats.fetch(:average_length)
    (weekly_cadence * average_episode_length).to_i
  end
end

