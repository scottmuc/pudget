require 'date'
require_relative '../domain/duration'

class FeedStats
  def self.for(rss)
    total_time = self.add_time(rss.items)
    number_of_episodes = number_of_episodes rss.items
    average_time = total_time / number_of_episodes
    release_cadence = self.release_cadence(rss.items)
    {
      :average_length => average_time,
      :podcast_name => rss.title,
      :total_time => total_time,
      :release_cadence => release_cadence,
    }
  end

  private
  def self.add_time(items)
    items.inject(0) do |sum, item|
      sum + Duration.parse(item.itunes_duration).minutes
    end
  end

  def self.number_of_episodes(items)
    items.count
  end

  def self.oldest_date(items)
    first = DateTime.parse(items.first.pubDate.to_s)
    last  = DateTime.parse(items.last.pubDate.to_s)
    [first, last].min
  end

  def self.release_cadence(items)
    initial_date = oldest_date items
    days = DateTime.now - initial_date
    number_of_episodes = number_of_episodes items
    (days / number_of_episodes).to_i
  end
end

