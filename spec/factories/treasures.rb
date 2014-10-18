FactoryGirl.define do
  factory :treasure do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    tag_list { Faker::Lorem.words.join(",") }
  end

end
