FactoryGirl.define do
  factory :post do
    title { Faker::GameOfThrones.quote }
    content { Faker::Hipster.paragraph }
    user
  end
end
