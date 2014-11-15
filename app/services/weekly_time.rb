require_relative 'feed_stats'

class WeeklyTime
  def self.for(rss)
    stats = FeedStats.for rss
    (7 / stats[:release_cadence].to_f * stats[:average_length]).to_i
  end
end

