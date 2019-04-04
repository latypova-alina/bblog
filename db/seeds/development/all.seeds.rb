FactoryGirl.create(:user)
FactoryGirl.create(:user, :admin)

3.times do
  FactoryGirl.create(:user, :author, :with_posts, :with_authors_avatar).tap do |author|
    FactoryGirl.create_list(:post, 3, :with_likes, user: author)
  end
end

FactoryGirl.create_list(:user, 3, :with_readers_avatar)

Post.all.each do |post|
  15.times do
    FactoryGirl.create(:comment, user: User.order("random()")[0], post: post)
  end
end
