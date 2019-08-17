require "rails_helper"

describe Authenticate::FindOrCreateUser do
  subject { described_class.call(decorated_auth_data: auth_data) } 

  let(:auth_data) do
    OmniAuth::AuthHash.new({
      email: "user@example.com",
      name: "John Smith",
      provider: "facebook",
      uid: "111222333"
    })
  end

  describe ".call" do
    context "when user with the same uid exists" do
      let!(:user) do 
        create :user, 
          email: "some_other_email@example.com", 
          full_name: "Mary Smith",
          provider: "facebook",
          uid: "111222333"
      end

      it { is_expected.to be_success }
      
      it "finds existing user" do 
        expect(subject.user).to eq(user)
        expect { subject }.to_not change{ User.count }
      end
    end

    context "when user with the same email exists" do
      let!(:user) do 
        create :user, 
          email: "user@example.com", 
          full_name: "Mary Smith"
      end

      it { is_expected.to be_success }
      
      it "finds existing user" do 
        expect(subject.user).to eq(user)
        expect { subject }.to_not change{ User.count }
      end
    end

    context "when user doesn't exist" do
      let(:user) { subject.user }

      it { is_expected.to be_success }

      it "creates user with name and email" do
        expect { subject }.to change{ User.count }.from(0).to(1)
        
        expect(user.full_name).to eq("John Smith")
        expect(user.email).to eq("user@example.com")
        expect(user.uid).to be_nil
        expect(user.provider).to be_nil
      end

      context "when auth data is invalid" do
        let(:auth_data) do
          OmniAuth::AuthHash.new({
            email: nil,
            name: "John Smith"
          })
        end

        it { is_expected.to be_a_failure }
      end
    end
  end
end
