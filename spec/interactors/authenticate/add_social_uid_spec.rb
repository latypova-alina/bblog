require "rails_helper"

describe Authenticate::AddSocialUid do
  subject { described_class.call(auth_data: auth_data, user: user) }

  let(:auth_data) do
    OmniAuth::AuthHash.new({
      provider: "facebook",
      uid: "111222333"
    })
  end

  let!(:user) do 
    create :user, 
      email: "user@example.com", 
      full_name: "Mary Smith"
  end

  describe ".call" do
    it { is_expected.to be_success }

    it "updates users auth data" do
      expect { subject }.to change { user.provider }.from(nil).to("facebook")
        .and change { user.uid }.from(nil).to("111222333")
    end

    context "when user is invalid" do
      let(:user) { build :user, email: nil }

      it { is_expected.to be_a_failure }
    end
  end
end
