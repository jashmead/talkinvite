# Be sure to restart your server when you modify this file.

# TBD:  replace cookie_store with a sessions table; more secure & no 4K limit
Talkinvite::Application.config.session_store :cookie_store, key: '_talkinvite_session'
