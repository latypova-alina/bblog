FactoryGirl.create(:user)
FactoryGirl.create(:user, :author, :with_posts)
FactoryGirl.create_list(:post, 7)
