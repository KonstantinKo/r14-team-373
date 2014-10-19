FactoryGirl.define do
  factory :user do
    sequence(:nickname) { Faker::Name.name}
    sequence(:email) {Faker::Internet.email }

    trait :admin do
      role 'admin'
    end

    trait :with_treasures do
       after(:create) do |user|
        FactoryGirl.create_list(:treasure, 10, user: user)
      end
    end


    trait :with_comments do
       after(:create) do |user|
        FactoryGirl.create_list(:comment, 15, user: user)
      end
    end
  end
end
