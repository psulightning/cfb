class AccountController < ApplicationController
  before_action :find_client, only: :checkin
  before_action :find_class, only: :checkin
  
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
      @service = MindBody::Services::ClassService.new
      if @client && !@class_obj
        time = Time.now

        response = @service.get_classes({"StartDateTime"=>Date.today,"EndDateTime"=>Date.today})
        if (response.status)!="Success" || response.result_count == "0"
          @errors = [response.message]
        elsif response.result[:classes].nil?
          @errors = ["There are no classes available."]
        else
          classes = response.result[:classes]
          classes = [classes] if classes.is_a?(MindBody::Models::Class)
          @classes = classes.select{|c|
            (c.start_date_time <= time && time <=c.end_date_time) || (c.start_date_time > time)
          }.sort{|a,b| a.start_date_time<=>b.start_date_time}
          curr_class = @classes.first
          
          @classes.shift if curr_class && ((curr_class.name != "Open Gym" && !(curr_class.start_date_time + 10.minutes > time)) || 
              (curr_class.name == "Open Gym" && curr_class.end_date_time < time))
          if @classes.empty?
            @classes = nil
            @errors = ["There are no classes available."]
          end
        end
      elsif @client && @class_obj
        register_class
      else
        @errors = ["Member not found."]
      end
    rescue Savon::SOAPFault => f
      @errors = ["A problem occurred!"]
      ExceptionNotifier.notify_exception(f,:env=>env)
    end
    render :layout=>nil
  end
  
  private
  def register_class
    response = @service.add_clients_to_classes({
        "ClientIDs"=>{"string"=>@client.id},
        "ClassIDs"=>{"int"=>@class_obj.id},
        "Test"=>true})
    if (response.status)!="Success"
      error_code = ""
      error_code = response.result[:classes][:clients][:error_code] if !response.result[:classes].nil?
      msg = case error_code
      when "601"
        "A valid membership is needed to check into this class."
      when "603"
        "Already signed into #{@class_obj.start_date_time.strftime("%l:%M %p")}"
      else
        "#{error_code} - #{response.result[:classes][:clients][:messages].gsub(/\n(.*)/,"")}"
      end
      @errors =  [msg]
    else
      first = @client.first_name
      last = @client.last_name
      @success = "Check In Successful for #{first} #{last} into #{@class_obj.name} at #{@class_obj.start_date_time.strftime("%l:%M %p")}"
    end
  end
  
  def find_client
    if params[:ident] && !params[:ident].empty?
      @client = MindBody::Services::ClientService.get_clients({"string"=>params[:ident]}).result[:clients]
    end
  end
  
  def find_class
    if params[:class_id] && !params[:class_id].empty?
      @class_obj = MindBody::Services::ClassService.get_classes({"ClassIDs"=>{"int"=>params[:class_id]}}).result[:classes]
    end
  end
end
