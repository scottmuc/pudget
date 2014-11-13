require_relative '../../lib/services/weekly_time'

describe WeeklyTime do
  it "reports around 60 minutes for the average podcast" do
    expect(FeedStats).to receive(:for) {
      { :release_cadence => 7,
        :average_length => 60
      }
    }
    time = WeeklyTime.for "some feed"
    expect(time).to eq(60)
  end

  it "reports little time for infrequently released podcasts" do
    expect(FeedStats).to receive(:for) {
      { :release_cadence => 30,
        :average_length => 45
      }
    }
    time = WeeklyTime.for "some feed"
    expect(time).to eq(10)
  end
end
