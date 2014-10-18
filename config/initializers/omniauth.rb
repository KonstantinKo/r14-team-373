Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user:email"
  provider :heroku, ENV['HEROKU_OAUTH_ID'], ENV['HEROKU_OAUTH_SECRET'], scope: "identity"
end
