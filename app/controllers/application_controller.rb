class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def facebook_cookies
    @facebook_cookies ||= Koala::Facebook::OAuth.new(YOUR_APP_ID, YOUR_SECRET).get_user_info_from_cookie(cookies)
  end
  
  private
  def logged
    if User.current.logged?
      true
    else
      flash[:error]="You must be logged in to view this page."
      redirect_to signin_path
    end
  end
  
  def find_model_object
    model = self.class.to_s.gsub("Controller","").singularize.capitalize.constantize
    if model
      object=model.send(:find,params[:id])
      self.instance_variable_set("@"+model.class.to_s.downcase,object) if object
    end
  end
end
