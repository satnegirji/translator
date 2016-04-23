ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/rails'

class MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class IntegrationTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  include Capybara::Assertions

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
