FactoryGirl.define do
  factory :user do
    nickname "Test User"
    email "test@example.com"

    trait :admin do
      role 'admin'
    end

    trait :with_treasures do
       after(:create) do |user|
        FactoryGirl.create_list(:treasure, 10, user: user)
      end
    end
  end
end
