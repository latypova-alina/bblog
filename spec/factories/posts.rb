FactoryGirl.define do
  factory :post do
    title { Faker::GameOfThrones.quote }
    content { Faker::Hipster.paragraph }
    image { File.open("spec/support/fixtures/post_image_#{rand(1..10)}.jpg") }
    user
  end

  trait :with_likes do
    after(:create) do |post|
      create_list :like, rand(50..100), post: post
    end
  end
end
