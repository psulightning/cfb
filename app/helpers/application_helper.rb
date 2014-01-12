module ApplicationHelper
  def show_flash_messages
    msg=""
    if !flash.keys.empty?
      flash.each{|k,v|
        msg << content_tag(:div,:class=>"alert alert-#{k}") do
          str = "<ul>"  
          str << case v
          when String
            "<li>#{v}</li>"
          when Array
            "<li>#{v.join("</li><li>")}</li>"
          else
            ""
          end
          str << "</ul>"
          str.html_safe
        end
        flash.delete(k)
      }
    end
    msg.html_safe
  end
  
  def current_user=(user_id)
    session[:current_user]=user_id
  end
  
  def current_user
    begin
    @current_user ||= session[:current_user] ? User.find(session[:current_user]) : User.new
    rescue Exception=>e
      session[:current_user]=nil
      @current_user ||= session[:current_user] ? User.find(session[:current_user]) : User.new
    end
  end

end
