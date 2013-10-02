# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
# 10/1/13 -- added password_confirmation, password_digest
Rails.application.config.filter_parameters += [:password, :password_confirmation, :password_digest]
