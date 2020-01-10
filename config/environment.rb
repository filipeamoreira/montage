# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Montage::Application.default_url_options = Montage::Application.config.action_mailer.default_url_options
