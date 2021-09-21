FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 10) }
    text { Faker::Lorem.characters(number: 30) }
    making_time { Faker::Lorem.characters(number: 10) }
    instrument { Faker::Lorem.characters(number: 30) }
    association :user
    after(:build) do |post|
      post.image.attach(io: File.open('app/assets/images/img/logo.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
