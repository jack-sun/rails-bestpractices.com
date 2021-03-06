require 'rubygems'
require 'spork'

Spork.prefork do
  require 'cucumber/rails'

  require 'email_spec' # add this line if you use spork
  require 'email_spec/cucumber'

  Capybara.default_selector = :css

  ActionController::Base.allow_rescue = false

  begin
    DatabaseCleaner.strategy = :truncation
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end

  # omniauth test
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = {
    'provider' => 'twitter',
    'uid' => '123456',
    'info' => {
      'nickname' => 'flyerhzm'
    },
    'credentials' => {
      'token' => 'abcdefg',
      'secret' => 'abcdefg'
    }
  }
  OmniAuth.config.mock_auth[:facebook] = {
    'provider' => 'facebook',
    'uid' => '123456',
    'info' => {
      'nickname' => 'flyerhzm'
    },
    'credentials' => {
      'token' => 'abcdefg',
    }
  }

  Before do
    Rails.cache.clear
  end
end

Spork.each_run do
  require 'factory_girl_rails'
end

