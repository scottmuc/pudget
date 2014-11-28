require_relative '../spec_helper'
require_relative '../../app/services/weekly_time'

describe WeeklyTime do
  it "reports around 60 minutes for the average podcast" do
    podcast = double(Podcast, :release_cadence => 7, :average_episode_play_time => 60)
    expect(WeeklyTime.for podcast).to eq 60
  end

  it "reports little time for infrequently released podcasts" do
    podcast = double(Podcast, :release_cadence => 30, :average_episode_play_time => 45)
    expect(WeeklyTime.for podcast).to eq 10
  end

  it "reports time for multiple podcasts" do
    all_podcasts = [ double(Podcast, :release_cadence => 7, :average_episode_play_time => 60),
                     double(Podcast, :release_cadence => 30, :average_episode_play_time => 45)]
    podcasts = double(Podcasts, :all => all_podcasts)
    expect(WeeklyTime.for_many podcasts).to eq 70
  end
end

