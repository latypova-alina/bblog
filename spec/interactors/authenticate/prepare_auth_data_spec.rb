require "rails_helper"

describe Authenticate::PrepareAuthData do
  subject(:auth_data_object) do
    described_class.call(auth_data: auth_data).decorated_auth_data
  end

  let(:auth_data) do
    OmniAuth::AuthHash.new(
      provider: "facebook",
      uid: "111222333",
      info: {
        email: "user@example.com",
        name: "John Smith"
      }
    )
  end

  describe ".call" do
    it "returns an object with all fields available" do
      expect(auth_data_object.email).to eq("user@example.com")
      expect(auth_data_object.name).to eq("John Smith")
      expect(auth_data_object.provider).to eq("facebook")
      expect(auth_data_object.uid).to eq("111222333")
    end
  end
end
