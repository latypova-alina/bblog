FactoryGirl.create(:user)
FactoryGirl.create(:user, :admin)

2.times do
  FactoryGirl.create(:user, :author, :with_posts, :with_avatar).tap do |author|
    FactoryGirl.create_list(:post, 3, :with_likes, user: author)
  end
end

FactoryGirl.create(:user, :author, :with_posts).tap do |author|
  FactoryGirl.create_list(:post, 3, :with_likes, user: author)
end
