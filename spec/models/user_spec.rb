require 'rails_helper'

RSpec.describe User, :type => :model do
  context "initializing a new user" do
    describe "with no parameters" do
      it "should have Anonymous status" do
        expect(User.new.anon?).to eq true
      end
    end
    describe "permission defined" do
      it "should build an admin user" do
        expect(User.new(permission: User::STATUS_ADMIN).admin?).to eq true
      end
      
      it "should build a coach" do
        user = User.new(permission: User::STATUS_COACH)
        expect(user.permission).to eq 3
      end
      
      it "should build a regular member" do
        user = User.new(permission: User::STATUS_MEMBER)
        expect(user.permission).to eq 2
      end
      
      it "should build a locked user" do
        expect(User.new(permission: User::STATUS_LOCKED).locked?).to eq true
      end
    end
  end
  
  context "matching password" do
    before do
      @user = create(:user, :password=>"foobar")
    end
    
    describe "with correct password" do
      it "should return true" do
        expect(@user.match_password?("foobar")).to eq true
      end
    end
    
    describe "with incorrect password" do
      it "should return false" do
        expect(@user.match_password?("barfoo")).to eq false
      end
    end
  end
  
  context "logged?" do
    describe "with regular member" do
      it "should return true" do
        user = create(:user)
        expect(user.logged?).to eq true
      end
    end
    
    describe "with anonymous user" do
      it "should return false" do
        user = create(:user, :permission=>User::STATUS_ANON)
        expect(user.logged?).to eq false
      end
    end
  end
  
  context "try_to_login" do
    before do
      @user = create(:user, :login=>"abc123@foo.bar", :password=>"barbell")
    end
    describe "with existing member" do
      it "should return the user" do
        expect(User.try_to_login("abc123@foo.bar", "barbell")).to eq @user
      end
    end
    
    describe "with bad creds" do
      it "should return nil" do
        expect(User.try_to_login("def456@bar.foo","bellbar")).to eq nil
      end
    end
  end
  
  context "age" do
    it "should return proper age for user" do
      user = create(:user, :birthday=>"1990-01-01")
      expect(user.age).to eq 25
    end
  end
end
