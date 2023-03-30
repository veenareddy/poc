require 'selenium-webdriver'

Given(/^I am on the home page$/) do
  @driver = Selenium::WebDriver.for :chrome
  @home_page = HomePage.new(@driver)
  @home_page.visit('https://www.example.com/')
end

When(/^I search for "([^"]*)"$/) do |query|
  @home_page.search_for(query)
end

Then(/^I should see a list of search results$/) do
  results = @driver.find_elements(css: '.search-result')
  expect(results.length).to be > 0
end

Then(/^each result should contain the word "([^"]*)"$/) do |word|
  results = @driver.find_elements(css: '.search-result')
  results.each do |result|
    expect(result.text).to include(word)
  end
end

Then(/^I should see a message indicating no results were found$/) do
  message = @driver.find_element(css: '.search-results-message')
  expect(message.text).to eq('No results found.')
end

After do
  @driver.quit
end
