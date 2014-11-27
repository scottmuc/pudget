require_relative '../../app/domain/podcast'
require_relative '../../app/services/weekly_time'

When(/^I lookup StartUp Podcast$/) do
  podcast = Podcast.fetch_rss "http://feeds.hearstartup.com/hearstartup"
  @weekly_time = WeeklyTime.for podcast
end

Then(/^the weekly committment time is displayed$/) do
  expect( @weekly_time ).to be > 10
end

