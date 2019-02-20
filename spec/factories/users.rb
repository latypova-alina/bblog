FactoryGirl.define do
  factory :user do
    email { generate :reader_email }
    full_name { Faker::Name.name }
    about_info { Faker::Hipster.paragraph }
    password "123456"
    password_confirmation { password }
    confirmed_at 1.hour.ago
  end

  trait :not_confirmed do
    confirmed_at nil

    after(:create) do |user|
      user.update(confirmation_sent_at: 3.days.ago)
    end
  end

  trait :author do
    role "author"
    email { generate :author_email }
  end

  trait :with_posts do
    after(:create) do |user|
      create_list :post, 3, user: user
    end
  end
end
