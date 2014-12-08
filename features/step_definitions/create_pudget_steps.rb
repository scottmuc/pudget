Given(/^that I am on the homepage$/) do
  visit '/'
end

When(/^I create a pudget$/) do
  find("#create").click
end

Then(/^I have a pudget$/) do
  expect( page ).to have_content 'make_this_random'
end

