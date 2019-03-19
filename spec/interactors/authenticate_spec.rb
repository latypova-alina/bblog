require "rails_helper"

describe Authenticate do
  subject(:authenticate) { described_class.call(auth_data: auth_data) }

  let(:auth_data) do
    {
      "email" => "user@example.com",
      "provider" => "facebook",
      "uid" => "111222333",
      "name" => "John Smith"
    }
  end

  let(:user) { authenticate.user }

  describe ".call" do
    context "when user with the same uid exists" do
      before { create :user, :with_social_uid, email: "some_other_email@example.com", full_name: "Mary Smith" }

      it "updates user with new social data" do
        expect(authenticate).to be_success

        expect(user.uid).to eq("111222333")
        expect(user.provider).to eq("facebook")
        expect(user.full_name).to eq("Mary Smith")
        expect(user.email).to eq("some_other_email@example.com")

        expect(User.count).to eq(1)
      end
    end

    context "when user with the same email exists" do
      before { create :user, email: "user@example.com", full_name: "Mary Smith" }

      it "updates user with new social data" do
        expect(authenticate).to be_success

        expect(user.uid).to eq("111222333")
        expect(user.provider).to eq("facebook")
        expect(user.full_name).to eq("Mary Smith")
        expect(user.email).to eq("user@example.com")

        expect(User.count).to eq(1)
      end
    end

    context "when user doesn't exist" do
      it "creates user with auth data" do
        expect(authenticate).to be_success

        expect(user.uid).to eq("111222333")
        expect(user.provider).to eq("facebook")
        expect(user.full_name).to eq("John Smith")
        expect(user.email).to eq("user@example.com")

        expect(User.count).to eq(1)
      end
    end
  end
end
