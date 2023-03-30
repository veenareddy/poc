require 'cucumber'
require 'selenium-webdriver'
require 'waitr'
require_relative 'test_data'

# Define the Selenium driver with desired options
Selenium::WebDriver::Chrome::Service.driver_path = "path/to/chromedriver"
options = Selenium::WebDriver::Chrome::Options.new(args: ['--disable-notifications'])
driver = Selenium::WebDriver.for(:chrome, options: options)

# Set the output directory for the report
Cucumber::Formatter::Html.configure do |config|
    report_path = 'reports/'
    config.out_stream = File.open(report_path + 'report.html', 'w')
    config.app_host = "http://localhost:3000"
end
  
# Define an array to store the step results
step_results = []


# Set the Waitr driver as the Selenium driver
Waitr.driver = driver

# Set the app host URL
app_host = "http://localhost:3000"

# Define a Before hook to navigate to the app host
Before do
  driver.navigate.to app_host
end

# Define an AfterStep hook to add the step result to the array
AfterStep do |scenario, step, result|
    step_results << result.to_sym
end

# Define an After hook to quit the browser
After do |scenario|
  if scenario.failed?
    # Take a screenshot on failure
    screenshot_path = "screenshots/#{scenario.name}.png"
    driver.save_screenshot(screenshot_path)
    puts "Screenshot saved to #{screenshot_path}"
  end

  # Quit the browser after each scenario
  driver.quit
  # Create a report for the scenario
  Cucumber::Formatter::Html.new(nil, nil).visit_test_case(scenario)

  # Determine the overall status of the scenario based on the step results
  status = :passed
  step_results.each do |result|
    if result == :failed
      status = :failed
      break
    elsif result == :undefined || result == :pending
      status = :undefined
    end
  end

  # Update the scenario status in the report
  Cucumber::Formatter::Html.new(nil, nil).scenario_visited(scenario)
  Cucumber::Formatter::Html.new(nil, nil).scenario_outline_visited(scenario)

  # Generate the report for the scenario
  Cucumber::Formatter::Html.new(nil, nil).after_features(nil)
end
