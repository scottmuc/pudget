
Given(/^that I have a pudget$/) do
  steps %Q{
    Given that I am on the homepage
    When I create a pudget
  }
end

When(/^I add (.+) Podcast$/) do |name|
  within('#addPodcast') do
    fill_in 'url', :with => podcast_urls.fetch("#{name} Podcast")
    click_button 'Add Podcast'
  end
end

When(/^I import Scott Muc's OPML feed$/) do
  within('#importOPML') do
    fill_in 'url', :with => "http://scottmuc.com/podcasts_opml.xml"
    click_button 'Import OPML'
  end
end

Then(/^(\d+) podcasts are displayed$/) do |podcast_number|
  expect( all(".podcast").count ).to eq podcast_number.to_i
end

