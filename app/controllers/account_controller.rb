class AccountController < ApplicationController
  def index
    @user=User.new
  end

  def login
    user = User.try_to_login(params[:login],params[:password])
    
    if user.nil?
      flash[:error]="Login failed"
      render :action=>"index"
    else
      user.update_attribute(last_login: Time.now)
      User.current=user
      redirect_to profile_path
    end
  end
  
  def facebook_login
    
  end

  def logout
    User.current=nil
  end
end
