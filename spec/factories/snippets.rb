FactoryGirl.define do
  factory :snippet do
    snippetable_type "MyString"
    description { Faker::Lorem.paragraph }
    snippetable_id 1
    link "https://github.com/railsrumble/r14-team-373/blob/e70ac466968d718209b63dfefff138c811405335/app/views/treasures/_tags.html.slim#L3"
    code <<-eos
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :developer unless Rails.env.production?
      provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user:email"
      provider :heroku, ENV['HEROKU_OAUTH_ID'], ENV['HEROKU_OAUTH_SECRET'], scope: "identity", fetch_info: true
    end
    eos
    
  end

end
