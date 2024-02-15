FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    email { Faker::Internet.email }
    password_digest { Faker::Internet.password(min_length: 6) }
  end
end
