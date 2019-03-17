RSpec.configure do |config|
  config.include Warden::Test::Helpers

  config.backtrace_exclusion_patterns << /\.bundle/

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
