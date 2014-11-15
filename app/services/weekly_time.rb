require_relative 'feed_stats'

class WeeklyTime
  def self.for(feed_url)
    stats = FeedStats.for feed_url
    (7 / stats[:release_cadence].to_f * stats[:average_length]).to_i
  end
end

