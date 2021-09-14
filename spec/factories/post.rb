# テストデータの定義を記述
# factories/モデル名.rbにテストデータの定義を記述する
FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:10) }
    text { Faker::Lorem.characters(number:30) }
    making_time { "making_time" }
    instrument { Faker::Lorem.characters(number:30) }
    genre { "genre" }
    user
  end
end