require 'rails_helper'

RSpec.describe AccountController, :type => :controller do
  describe "when logging in" do
    describe "with invalid params" do
      describe "with no email address or password" do
        it "should render index" do
          expect(User).to receive(:try_to_login).with(nil,nil).and_return(nil)
          post :login
          expect(response).to render_template(:index)
        end
      end
      describe "with no email address" do
        it "should render index" do
          expect(User).to receive(:try_to_login).with(nil,"abc123").and_return(nil)
          post :login, {password: "abc123"}
          expect(response).to render_template(:index)
        end
      end
      describe "with no password" do
        it "should render index" do
          expect(User).to receive(:try_to_login).with("admin@localhost",nil).and_return(nil)
          post :login, {login: "admin@localhost"}
          expect(response).to render_template(:index)
        end
      end
    end
    describe "with valid params" do
      describe "with a locked user" do
        it "should render index" do
          user = User.find_by_login("locked@localhost")
          expect(User).to receive(:try_to_login).with("locked@localhost","123abc").and_return(user)
          post :login, {login: "locked@localhost", password: "123abc"}
          expect(response).to render_template(:index)
        end
      end
    end
  end
end
