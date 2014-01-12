class AccountController < ApplicationController
  def index
    @user=User.new
  end

  def login
    user = User.try_to_login(params[:login],params[:password])
    if user.nil?
      flash[:error]="Login failed"
      render :action=>"index"
    elsif user.locked?
      flash[:error]="Your account has been locked."
      render :action=>"index"
    else
      user.update_attribute(:last_login, Time.now)
      self.current_user=user
      redirect_to profile_path
    end
  end
  
  def facebook_login
    
  end

  def logout
    self.current_user= nil
    redirect_to root_url
  end
  
end
