require_relative '../../app/domain/podcast'
require_relative '../../app/domain/podcasts'
require_relative '../../app/services/weekly_time'

When(/^I lookup StartUp Podcast$/) do
  podcast = Podcast.fetch_rss "http://feeds.hearstartup.com/hearstartup"
  @weekly_time = WeeklyTime.for(podcast)
end

When(/^I lookup Scott Muc's podcast list$/) do
  podcasts = Podcasts.fetch_opml "http://scottmuc.com/podcasts_opml.xml"
  @weekly_time = podcasts.weekly_time
end

Then(/^the weekly committment time is displayed$/) do
  expect( @weekly_time ).to be > 10
end

