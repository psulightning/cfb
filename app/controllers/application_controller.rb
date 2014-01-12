class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  
  before_action :check_for_mobile
  
  def facebook_cookies
    @facebook_cookies ||= Koala::Facebook::OAuth.new(YOUR_APP_ID, YOUR_SECRET).get_user_info_from_cookie(cookies)
  end
  
  def check_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]
    prepare_for_mobile if mobile_device?
  end

  def prepare_for_mobile
    prepend_view_path Rails.root + 'app' + 'views_mobile'
  end

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == "1"
    else
      # Season this regexp to taste. I prefer to treat iPad as non-mobile.
      (request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)
    end
  end
  helper_method :mobile_device?
  
  
  private
  
  def logged
    if current_user.logged?
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
