Given(/^that I am on the homepage$/) do
  visit '/'
end

When(/^I create a pudget$/) do
  find("#create").click
end

Then(/^a new pudget is created$/) do
  pudget_url = find("#pudgetUrl")[:href]
  expect( pudget_url ).to match '/pudget/.+'
end

