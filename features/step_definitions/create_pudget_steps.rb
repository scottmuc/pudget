Given(/^that I am on the homepage$/) do
  get '/'
end

When(/^I create a pudget$/) do
  post '/pudget/create'
end

Then(/^I have a pudget$/) do
  expect( last_response.ok? ).to be true
end

