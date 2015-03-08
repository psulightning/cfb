require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe "when registering" do
    describe "with GET" do
      it "should render register template" do
        get :register
        expect(response).to render_template(:register)
      end
    end
    describe "with POST" do
      let(:params) {{:user=>{:first=>"Jim", :last=> "Smith", :birthday=>"01/01/1990", :gender=>"M", :login=>"jsmith@mail.com", :password=>"password", :confirm=>"password"}}}
      def post_register(params)
        post :register, params
      end
      describe "with valid params" do
        it "should create new user" do
          expect(User.count).to eq(0)
          post_register(params)
          expect(User.count).to eq(1)
        end
        
        it "should set auth_token cookie" do
          lt = LoginToken.new
          expect(LoginToken).to receive(:create!).and_return(lt)
          post_register(params)
          expect(cookies['auth_token']).to eq(lt.token)
        end

        it "should redirect to profile page" do
          post_register(params)
          expect(response).to redirect_to(:profile)
        end
      end
      
      describe "with invalid params" do
        def ar_error_message(field)
          expect(flash[:error]).to eq("#{field.capitalize} can't be blank")
        end
        
        def clear_param_field(field)
          params[:user]= params[:user].except(field.to_sym)
        end
        
        describe "set flash[:error]" do
          it "for blank login" do
            clear_param_field(:login)
            post_register(params)
            ar_error_message(:login)
          end
          
          it "for blank password" do
            clear_param_field(:password)
            post_register(params)
            expect(flash[:error]).to eq("Password confirmation doesn't match Password")
          end
          
          it "for blank confirmation" do
            clear_param_field(:confirm)
            post_register(params)
            expect(flash[:error]).to eq("Password confirmation can't be blank")
          end
          
          it "for blank first name" do
            clear_param_field(:first)
            post_register(params)
            expect(flash[:error]).to eq("First name can't be blank")
          end
        end
      end
    end
  end
end

