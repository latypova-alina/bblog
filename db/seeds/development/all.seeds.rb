FactoryGirl.create(:user)

3.times do
  FactoryGirl.create(:user, :author, :with_posts, :with_avatar).tap do |author|
    FactoryGirl.create_list(:post, 3, user: author)
  end
end
