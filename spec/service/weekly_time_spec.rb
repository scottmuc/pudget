require_relative '../../lib/services/weekly_time'

describe WeeklyTime do
  def stub_feed_stats(stats)
    expect(FeedStats).to receive(:for) { stats }
  end

  it "reports around 60 minutes for the average podcast" do
    stub_feed_stats({ :release_cadence => 7, :average_length => 60 })
    expect(WeeklyTime.for double).to eq 60
  end

  it "reports little time for infrequently released podcasts" do
    stub_feed_stats({ :release_cadence => 30, :average_length => 45 })
    expect(WeeklyTime.for double).to eq 10
  end
end

