require 'rails_helper'

RSpec.describe User, :type => :model do
  context "generate token" do
    it "should set auth_token field" do
      user = User.find_by_login("admin@localhost")
      user.generate_token(:auth_token)
      expect(user.auth_token).not_to eq(nil)
    end
  end
end
