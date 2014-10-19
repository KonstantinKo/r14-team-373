FactoryGirl.define do
  factory :comment do
    sequence(:content) { |n| "#{Faker::Lorem.paragraph}" }
  end
end
