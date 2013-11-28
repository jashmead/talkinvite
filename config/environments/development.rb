Talkinvite::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  # setting this to true splits the application.js & application.css files into their parts
  #   server restart required
  #   may slow things down, however
  config.assets.debug = false

  # per upgrade from Rails 3.1 to 3.2:  https://github.com/rails/docrails/blob/master/guides/source/upgrading_ruby_on_rails.md
  # config.active_record.mass_assignment_sanitizer = :strict  # not needed with strong parameters
  # config.active_record.auto_explain_threshold_in_seconds = 0.5  # eliminated in Rails 4.0

end
