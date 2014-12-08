
Given(/^that I have a pudget$/) do
  steps %Q{
    Given that I am on the homepage
    When I create a pudget
  }
end

When(/^I add Startup Podcast$/) do
  within('form') do
    fill_in 'url', :with => "http://feeds.hearstartup.com/hearstartup"
    click_button 'Add Podcast'
  end
end

When(/^I add EconTalk Podcast$/) do
  within('form') do
    fill_in 'url', :with => "http://files.libertyfund.org/econtalk/EconTalk.xml"
    click_button 'Add Podcast'
  end
end

Then(/^both podcasts are displayed$/) do
  expect( all("ul li").count ).to eq 2
end

