Before do |scenario|
    # Do something before each scenario
end

After do |scenario|
    # Do something after each scenario
end

Before '@tag' do |scenario|
    # Do something before scenarios tagged with '@tag'
end

After '@tag' do |scenario|
    # Do something after scenarios tagged with '@tag'
end

Before '@tag1, @tag2' do |scenario|
    # Do something before scenarios tagged with '@tag1' OR '@tag2'
end

AfterStep do |scenario, step|
    # Do something after each step add
end

AfterConfiguration do
    # Do something after Cucumber configuration is loaded
end

at_exit do
    # Do something after all Cucumber tests have finished
end
  