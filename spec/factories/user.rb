FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    encryped_password { "password" }
    name { "山田太郎" }
    display_name { "たろう" }
    introduction { "making_time" }
    url { "url" }
  end
end
