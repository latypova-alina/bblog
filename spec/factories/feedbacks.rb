FactoryGirl.define do
  factory :feedback do
    email { Faker::Internet.email }
    name  { Faker::Name.name }
    message { Faker::Hipster.paragraph }
  end
end
