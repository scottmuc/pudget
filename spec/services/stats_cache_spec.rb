require_relative '../../app/services/stats_cache'

describe StatsCache do
  it "remembers stats" do
    stats = double
    StatsCache.save_stats("podcast url", stats)
    expect( StatsCache.for_podcast("podcast url") ).to eq stats
  end
end

