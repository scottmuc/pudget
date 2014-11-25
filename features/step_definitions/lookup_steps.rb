require_relative '../../app/domain/podcast'
require_relative '../../app/services/weekly_time'
require_relative '../../app/services/stats_cache'

Given(/^Serial Podcast is cached with a time of 20$/) do
  stats = { :average_length => 20, :release_cadence => 7 }
  StatsCache.save_stats("http://feeds.serialpodcast.org/serialpodcast", stats)
end

When(/^I lookup StartUp Podcast$/) do
  rss = Podcast.fetch_rss "http://feeds.hearstartup.com/hearstartup"
  stats = FeedStats.for rss
  @weekly_time = WeeklyTime.for stats
end

Then(/^the weekly committment time is displayed$/) do
  expect( @weekly_time ).to be > 10
end

When(/^I lookup Serial Podcast$/) do
  stats = StatsCache.for_podcast "http://feeds.serialpodcast.org/serialpodcast"
  @weekly_time = WeeklyTime.for stats
end

Then(/^then a time of 20 minutes is displayed$/) do
  expect( @weekly_time ).to eq 20
end

