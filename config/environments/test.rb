Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # App custom config vars
  # Campaign start date. This is the date filter for the first read, 
  # after that, the app will not longer use it, 
  # because the app will use the last timestamp read
  # Format: "mm/dd/YYYY h:m:s"
  config.start_date = "01/28/2019 00:00:00"
  # Minutes between each sync
  config.sync_minutes = 1
  
  # Custom logs paths
  config.sync_logger = "#{Rails.root}/log/sync.log"
  config.candidates_logger = "#{Rails.root}/log/candidates.log"

  # Google API config vars
  config.google_api_key = "Google API key"
  config.google_sheet_id = "Google Sheet id"

  # Talkpush API config vars
  config.talkpush_api_key = "Talkpush API key"
  config.talkpush_api_secret = "Talkpush API secret"
  config.talkpush_campaign_id = 0000 # Talkpush campaign id
  
  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure public file server for tests with Cache-Control for performance.
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{1.hour.to_i}"
  }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Store uploaded files on the local file system in a temporary directory
  config.active_storage.service = :test

  config.action_mailer.perform_caching = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
