shared_context "current user signed in" do
  let(:current_user) { create :user }

  before do
    login_as current_user
  end
end
