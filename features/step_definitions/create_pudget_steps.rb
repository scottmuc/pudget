Given(/^that I am on the homepage$/) do
  visit '/'
end

When(/^I create a pudget$/) do
  find("#create").click
end

Then(/^I have a pudget$/) do
  pudget_url = find("#pudgetUrl")[:href]
  expect( pudget_url ).to match 'make_this_random'
end

