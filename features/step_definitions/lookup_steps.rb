require_relative '../../app/services/weekly_time'

When(/^I lookup StartUp Podcast$/) do
  @weekly_time = WeeklyTime.for "http://feeds.hearstartup.com/hearstartup"
end

Then(/^then the weekly committment time is displayed$/) do
  expect( @weekly_time ).to be > 10
end

