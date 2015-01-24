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
        before do
          @user = create(:user, :locked)
          expect(User).to receive(:try_to_login).and_return(@user)
          post :login, {login: @user.login, password: @user.password}
        end
        
        it "should tell user account is locked via the flash hash" do
          expect(flash[:error]).to eq "Your account has been locked."
        end
        
        it "should render index" do
          expect(response).to render_template(:index)
        end
      end
      describe "with valid user" do
        describe "without permanent login selected" do
          before do
            @user = create(:user)
            expect(User).to receive(:try_to_login).and_return(@user)
            post :login, {login: @user.login, password: @user.password}
          end
        
          it "should create a session cookie" do
            expect(cookies[:auth_token]).not_to be_nil
          end
          
          it "should set the cookie to auth_token" do
            expect(cookies[:auth_token]).to eq @user.token.token
          end
        
          it "should redirect to profile" do
            expect(response).to redirect_to(profile_path)
          end
        end
        describe "with permanent login selected" do
          before do
            @user = create(:user)
            expect(User).to receive(:try_to_login).and_return(@user)
            post :login, {login: @user.login, password: @user.password, remember: true}
          end
        
          it "should create a cookie" do
            expect(cookies[:auth_token]).not_to be_nil
          end
          
          it "should set the cookie to auth_token" do
            expect(cookies[:auth_token]).to eq @user.token.token
          end
        
          it "should redirect to profile" do
            expect(response).to redirect_to(profile_path)
          end
        end
      end
    end
  end
end
