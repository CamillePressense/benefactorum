# this condition is needed for build step : RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile
# because Rails.application.credentials is not available in this context as RAILS_MASTER_KEY is not set to decrypt rails secrets
if Rails.application.credentials.mailjet.present?
  Mailjet.configure do |config|
    config.api_key = Rails.application.credentials.mailjet.api_key
    config.secret_key = Rails.application.credentials.mailjet.secret_key
    config.default_from = "contact@benefactorum.org"
    # Mailjet API v3.1 is at the moment limited to Send API.
    # We’ve not set the version to it directly since there is no other endpoint in that version.
    # We recommend you create a dedicated instance of the wrapper set with it to send your emails.
    # If you're only using the gem to send emails, then you can safely set it to this version.
    # Otherwise, you can remove the dedicated line into config/initializers/mailjet.rb.
    config.api_version = "v3.1"
  end
end
