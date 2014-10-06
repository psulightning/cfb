class UsersController < ApplicationController
  before_filter :logged, :except=>[:register]
  before_filter :find_model_object, :except=>[:register,:profile]
  
  def edit
  end

  def update
    @user.assign_attributes(user_params)
    @user.permission = params[:user][:permission] if params[:user][:permission]
    unless @user.match_password?(params[:user][:password])
      @user.password,@user.password_confirmation=params[:user][:password],params[:user][:confirm]
    end
  end
  
  def show
    @user=User.find(params[:id])
  end
  
  def register
    if request.get?
      @user=User.new
    else
      @user=User.new
      @user.assign_attributes(user_params)
      @user.permission=User::STATUS_MEMBER
      @user.password,@user.password_confirmation=params[:user][:password],params[:user][:confirm]
      if @user.save
        lt = LoginToken.create!(:user=>@user,:permanent=>false)
        cookies[:auth_token]=lt.token
        @user.update_column(:last_login, Time.now)
        @user.update_column(:updated_at, Time.now)
        redirect_to profile_path
      else
        flash[:error]=@user.errors.full_messages.join("<br/>").html_safe
      end
    end
  end
  
  def profile
    @user = current_user
  end
  
  private
  def user_params
    params.require(:user).permit(:first,:last,:birthday,:login,:gender)
  end
end
