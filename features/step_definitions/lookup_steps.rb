require_relative '../../app/services/rss_retriever'
require_relative '../../app/services/weekly_time'

When(/^I lookup StartUp Podcast$/) do
  rss = RSSRetriever.fetch_rss "http://feeds.hearstartup.com/hearstartup"
  @weekly_time = WeeklyTime.for rss
end

Then(/^the weekly committment time is displayed$/) do
  expect( @weekly_time ).to be > 10
end

