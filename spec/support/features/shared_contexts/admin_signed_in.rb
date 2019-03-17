shared_context "admin signed in" do
  let(:current_user) { create :user, :admin }

  before do
    login_as current_user
  end
end
