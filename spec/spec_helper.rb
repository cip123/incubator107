require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'



Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'
  
  require 'factory_girl'
  require 'capybara/rspec'
  require 'capybara/webkit/matchers'
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"
    # Use color in STDOUT
    #config.color_enabled = true

    config.tty = true

    config.formatter = :documentation # :progress, :html, :textmate
    config.include Capybara::DSL
    config.include Rails.application.routes.url_helpers


    config.before(:each) do |example|
      DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    end
    
    config.after(:each) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.after(:all) do
      DatabaseCleaner.clean_with(:truncation)
    end

    # config.before(:each) do
    #   DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    #   DatabaseCleaner.start
    # end

    config.include(Capybara::Webkit::RspecMatchers, :type => :feature)

    Capybara.configure do |capybara_config|
      capybara_config.javascript_driver = :webkit
      capybara_config.server_port = 3001
      capybara_config.app_host = "lvh.me"
    end

  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end

# --- Instructions ---
# Sort the contents of this file into a Spork.prefork and a Spork.each_run
# block.
#
# The Spork.prefork block is run only once when the spork server is started.
# You typically want to place most of your (slow) initializer code in here, in
# particular, require'ing any 3rd-party gems that you don't normally modify
# during development.
#
# The Spork.each_run block is run each time you run your specs.  In case you
# need to load files that tend to change during development, require them here.
# With Rails, your application modules are loaded automatically, so sometimes
# this block can remain empty.
#
# Note: You can modify files loaded *from* the Spork.each_run block without
# restarting the spork server.  However, this file itself will not be reloaded,
# so if you change any of the code inside the each_run block, you still need to
# restart the server.  In general, if you have non-trivial code in this file,
# it's advisable to move it into a separate file so you can easily edit it
# without restarting spork.  (For example, with RSpec, you could move
# non-trivial code into a file spec/support/my_helper.rb, making sure that the
# spec/support/* files are require'd from inside the each_run block.)
#
# Any code that is left outside the two blocks will be run during preforking
# *and* during each_run -- that's probably not what you want.
#
# These instructions should self-destruct in 10 seconds.  If they don't, feel
# free to delete them.




# This file is copied to spec/ when you run 'rails generate rspec:install'



# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.


#def default_url_options(options = {})
#  { :host => "lvh.me", :port => Capybara.server_port }.merge(options)
#end
#Capybara.server_port = 3001


