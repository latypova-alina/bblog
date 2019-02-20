FactoryGirl.create(:user)
FactoryGirl.create(:user, :author, :with_posts, :with_avatar)
FactoryGirl.create_list(:post, 7)
