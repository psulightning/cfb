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
  
  def checkin
    if request.get?
      render :layout=>nil
      return
    end
    @errors = nil
    begin
      if params[:ident]
        service = ClassService.new
        response = service.get_classes({"SchedulingWindow"=>true})
        if (status = response.xpath("//Status").text)!="Success"
          @errors = [status, response.xpath("//Message").text]
        elsif response.xpath("//Classes").children.length==0
          @errors = ["There are no classes available."]
        else
          class_id = response.xpath("//Classes/Class[1]/ID").text.to_i
          response = service.add_clients_to_classes({"Test"=>true,
              "ClientIDs"=>{"string"=>params[:ident]},
              "ClassesID"=>{"int"=>class_id}})
          if (status=response.xpath("//Status").text)!="Success"
            @errors = [status, response.xpath("//Message").text]
          else
            first = response.xpath("//Client/FirstName").text
            last = response.xpath("//Client/LastName").text
            @success = "Check In Successful for #{first} #{last}"
          end
        end
      else
        @errors = ["No ID entered."]
      end
    rescue Savon::SOAPFault => f
      @errors = ["A problem occurred!"]
      ExceptionNotifier.notify_exception(f,:env=>env)
    end
    render :layout=>nil
  end
  
end
