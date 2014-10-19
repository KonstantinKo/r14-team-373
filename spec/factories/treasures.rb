FactoryGirl.define do
  factory :treasure do
    sequence(:title) { |n| "#{Faker::Lorem.word}-#{n}" }
    description { Faker::Lorem.paragraph }
    tag_list { Faker::Lorem.words.join(",") }
    user_id { FactoryGirl.create(:user).id }
    trait :with_comments do
       after(:create) do |treasure|
        FactoryGirl.create_list(:comment, 15, treasure: treasure, user_id: User.first.id)
      end
    end

    trait :with_snippets do
       after(:create) do |treasure|
        FactoryGirl.create_list(:snippet, 3, user_id: User.first.id)
      end
    end
  end

end
