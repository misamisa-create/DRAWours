FactoryBot.define do
  factory :user do
    email { Faker::Lorem.characters(number: 10) }
    password { Faker::Lorem.characters(number: 10) }
    name { Faker::Lorem.characters(number: 10) }
    display_name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 30) }
    url { Faker::Lorem.characters(number: 10) }
  end
end
