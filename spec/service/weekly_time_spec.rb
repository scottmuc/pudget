require_relative '../../app/services/weekly_time'

describe WeeklyTime do
  it "reports around 60 minutes for the average podcast" do
    stats = { :release_cadence => 7, :average_length => 60 }
    expect(WeeklyTime.for stats).to eq 60
  end

  it "reports little time for infrequently released podcasts" do
    stats = { :release_cadence => 30, :average_length => 45 }
    expect(WeeklyTime.for stats).to eq 10
  end
end

