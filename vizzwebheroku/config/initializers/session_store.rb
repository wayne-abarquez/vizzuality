# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_vizzuality_session',
  :secret      => '5d2a2681e864925ca4827a00ca9a03ca9eaa1a9fb5c2cb915b1c9c3557684fff92b42765f5803bcd1779fba57ae5a26f3674c0171ed7668194b3ea0de92c8f8b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
