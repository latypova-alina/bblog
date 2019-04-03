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

10.times do
  FactoryGirl.create(:user).tap do |user|
    FactoryGirl.create_list(:comment, 3, user: user, post: Post.order("RANDOM()")[0])
  end
end
