
Given(/^that I have a pudget$/) do
  steps %Q{
    Given that I am on the homepage
    When I create a pudget
  }
end

When(/^I add (.+) Podcast$/) do |name|
  within('form') do
    fill_in 'url', :with => podcast_urls.fetch("#{name} Podcast")
    click_button 'Add Podcast'
  end
end

Then(/^both podcasts are displayed$/) do
  expect( all("ul li").count ).to eq 2
end

