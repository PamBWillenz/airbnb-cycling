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
require 'pundit/rspec'
include ActionDispatch::TestProcess

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include SimpleBdd, type: :feature
  # config.include Devise::TestHelpers, :type => :controller  

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  Capybara.javascript_driver = :webkit

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do 
    DatabaseCleaner.clean
  end

  config.include Warden::Test::Helpers
  config.before :suite do 
    Warden.test_mode!
  end 

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!
  
  config.filter_rails_from_backtrace!

end
    
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end  
  
  

  


