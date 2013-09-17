class UsersController < ApplicationController
  before_filter :logged
  before_filter :find_model_object, :except=>[:register,:profile]
  
  def edit
  end

  def update
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
        User.current = @user
        redirect_to profile_path
      else
        flash[:error]=@user.errors.full_messages.join("<br/>").html_safe
      end
    end
  end
  
  def profile
    @user = User.current
  end
  
  private
  def user_params
    params.require(:user).permit(:first,:last,:birthday,:login,:gender)
  end
end
