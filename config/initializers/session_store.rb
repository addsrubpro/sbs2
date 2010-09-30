# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sbs2_session',
  :secret      => '11561c0b82b00bf15eab59ebe4be693293086f6e8b4324ea5440e541ce95b3908ec3824a9c84cb5d1f39ec6f089ad95ad94ab1b5ace357a737b820b93398c088'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
