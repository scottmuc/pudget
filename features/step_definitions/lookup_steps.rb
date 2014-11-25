require_relative '../../app/services/podcast'
require_relative '../../app/services/weekly_time'

When(/^I lookup StartUp Podcast$/) do
  rss = Podcast.fetch_rss "http://feeds.hearstartup.com/hearstartup"
  stats = FeedStats.for rss
  @weekly_time = WeeklyTime.for stats
end

Then(/^the weekly committment time is displayed$/) do
  expect( @weekly_time ).to be > 10
end

