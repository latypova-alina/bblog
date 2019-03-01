FactoryGirl.define do
  sequence(:admin_email) { |n| "admin_#{n}@example.com" }
  sequence(:author_email) { |n| "author_#{n}@example.com" }
  sequence(:reader_email) { |n| "reader_#{n}@example.com" }
end
