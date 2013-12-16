OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['CURRENTLY_FACEBOOK_APP_ID'], ENV['CURRENTLY_FACEBOOK_SECRET']
end