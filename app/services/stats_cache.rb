class StatsCache
  @@CACHE = {}

  def self.save_stats(podast_url, stats)
    @@CACHE[podast_url] = stats
  end

  def self.for_podcast(podcast_url)
    @@CACHE.fetch(podcast_url)
  end
end

