FactoryGirl.define do
  factory :comment do
    content { Faker::Hipster.paragraph }
    user
    post
  end
end
