class ContactController < ApplicationController
  def index
    @mail=
      {name: current_user.anon? ? "" : current_user.to_s, 
      address: current_user.login || "",
      phone: "",
      msg: "",
      pref: nil
    }
  end
  
  def send_mail
    @mail=params[:mail]
    @errors=[]
    @mail.each { |k,v|
      @errors << "#{k.to_s.capitalize} cannot be blank" if v.blank?
      case k
      when "address"
        match = v.match(/[a-z0-9!#%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/)
        unless match
          @errors << "Email is not valid"
        end
      when "phone"
        match= v.match(/[2-9]\d{2}-[2-9][0,2-9][0,2-9]-\d{4}/)
        unless match
          @errors << "Phone format is 410-555-5555"
        end
      end
    }
    @errors << "Preference is required" if !@mail.has_key?(:pref)
    if !@errors.empty?
      flash[:error]=@errors
      render :action=>:index
    else
      begin
      Mailer.contact(@mail).deliver
      rescue Exception
        flash[:error]="There was system problem sending your email."
        render :action=>:index
        return
      end
      redirect_to :action=>:index
      flash[:success]="Email successfully sent."
    end
  end
end
