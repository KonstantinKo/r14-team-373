FactoryGirl.define do
  factory :treasure do
    sequence(:title) { |n| "#{Faker::Lorem.word}-#{n}" }
    description { Faker::Lorem.paragraph }
    tag_list { Faker::Lorem.words.join(",") }
  end

end
