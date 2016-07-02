ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/rails'
require "capybara/rails"
require "capybara/poltergeist"
require "database_cleaner"
require "support/share_db_connection"
class MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end

class IntegrationTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  include Capybara::Assertions

  def setup
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start

  end

  def teardown
    DatabaseCleaner.clean
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
