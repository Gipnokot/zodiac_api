Apipie.configure do |config|
  config.app_name                = "ZodiacApi"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/apipie"
  config.translate               = false
  config.validate                = false
  config.reload_controllers      = true
  config.default_version         = "v1"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/v1/*.rb"
end
