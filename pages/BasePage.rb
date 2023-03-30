require 'selenium-webdriver'

class BasePage
  def initialize(driver)
    @driver = driver
  end

  def visit(url)
    @driver.navigate.to(url)
  end

  def find(locator)
    @driver.find_element(locator)
  end

  def click(locator)
    find(locator).click
  end

  def fill_in(locator, with:)
    find(locator).send_keys(with)
  end

  def wait_for(seconds=10)
    Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
  end
end
