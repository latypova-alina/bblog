shared_context "author signed in" do
  let(:current_user) { create :user, :author }

  before do
    login_as current_user
  end
end
