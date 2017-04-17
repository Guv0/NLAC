require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "client_id", "client_secret"
end
