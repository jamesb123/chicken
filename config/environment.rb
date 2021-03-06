# data entry project Be sure to restart your server when you modify this file
# require 'thread'

# DO NOT REMOVE THIS LINE - It's important for the fcgid deployment we are using.
begin
  ENV['RAILS_SITE'] = "TRACKER"
  ENV['RAILS_ENV'] = File.read("config/RAILS_ENV").strip if ENV['RAILS_ENV'] == 'production'
  ENV['RAILS_SITE'] = File.read("config/RAILS_SITE").strip 
rescue 
end


# Specifies gem version of Rails to use when vendor/rails is not present
 RAILS_GEM_VERSION = '2.3.9' unless defined? RAILS_GEM_VERSION
# RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
# RAILS_GEM_VERSION = '2.1.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

::RESULT_TABLES = %w[genders microsatellites mhcs mt_dnas y_chromosomes surveys sightings]

# Fixes problems with ruby 1.8.7
unless '1.9'.respond_to?(:force_encoding)
  String.class_eval do
    begin
      remove_method :chars
    rescue NameError # OK
    end
  end
end

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.autoload_paths += %W( #{RAILS_ROOT}/extras )
  # config.gem 'hoptoad_notifier'
  # config.gem "fastercsv"
  # config.gem "newrelic_rpm" 
  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "fastercsv"  
  # config.gem "paperclip", :verion => "~> 2.7"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
# date_format = { :default => '%y.%m.%d' } 
 mydate_format = { :default => '%d.%m.%Y' } 
#ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(:default => "%Y.%m.%d")
#ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(:default => "%H:%M,:%S")

#ActionMailer::Base.smtp_settings = {
#   :address => "nrdpfcbackup.info",
#   :port => 26,
#   :domain => "nrdpfcbackup.info",
#   :authentication => :login,
#   :user_name => "dna@nrdpfcbackup.info",
#   :password => "nrdpfc12",
#}
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp 
#  config.action_mailer.delivery_method = :file 
  config.action_mailer.default_content_type = "text/html" 
  config.action_mailer.default_url_options = { :host => "burrett.org" } 
  config.action_mailer.smtp_settings = { 
    :tls              => false, 
    :address          => "burrett.org", 
    :port             => 26, 
    :domain           => "burrett.org", 
    :authentication   => :login,
    :user_name        => "nrdpfc@burrett.org", 
    :password         => "nrdpfc12" 
  } 
  
end