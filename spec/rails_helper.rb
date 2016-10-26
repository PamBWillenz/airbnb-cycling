# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'simple_bdd'
require 'shoulda/matchers'
include ActionDispatch::TestProcess
#Capybara.javascript_driver = :webkit

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do 
    DatabaseCleaner.clean
  end

# config.include Devise::TestHelpers, :type => :controller  

config.include SimpleBdd, type: :feature
    
    Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
      end
    end  
  
  config.include Warden::Test::Helpers
  config.before :suite do 
    Warden.test_mode!
  end 

  config.infer_spec_type_from_file_location!
  
  config.filter_rails_from_backtrace!

end
