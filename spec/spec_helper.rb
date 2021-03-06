require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  #require 'shoulda/matchers/integrations/rspec'

  require "rails/application"
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    config.mock_with :rspec

    require 'database_cleaner'
    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:transaction)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  RSpec.configure do |config|
    #I18n.backend.reload! # uncomment if I18n is used
    Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

    # reloads factory settings
    require 'factory_girl'
    FactoryGirl.definition_file_paths = [ File.join(Rails.root, 'spec', 'factories') ]
    FactoryGirl.find_definitions
  end

end


