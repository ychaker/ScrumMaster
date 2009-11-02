# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_scrum_master_session',
  :secret      => '66be026e9348119370ac6fddea2b1fecc2cd92c31d762c66c917233747b8d3dd75fdf3453586ecdf82ab3d22fdfbd79c85de42a8d5573616bc457ae0565f8feb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
