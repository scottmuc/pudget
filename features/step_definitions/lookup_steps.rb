require_relative '../../app/domain/podcast'
require_relative '../../app/domain/podcasts'

When(/^I lookup StartUp Podcast$/) do
  podcast = Podcast.fetch_from_the_internet! podcast_urls.fetch('Startup Podcast')
  @weekly_time = podcast.weekly_time
end

When(/^I lookup Scott Muc's podcast list$/) do
  podcasts = Podcasts.fetch_from_the_internet! "http://scottmuc.com/podcasts_opml.xml"
  @weekly_time = podcasts.reduce(0) { |sum,podcast| sum += podcast.weekly_time }
end

Then(/^the weekly committment time is displayed$/) do
  expect( @weekly_time ).to be > 10
end

