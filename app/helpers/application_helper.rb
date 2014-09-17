module ApplicationHelper
  def show_flash_messages
    msg=""
    if !flash.keys.empty?
      flash.each{|k,v|
        klass = k== "error" ? "danger" : k
        msg << content_tag(:div,:class=>"alert alert-#{klass}",:role=>"alert") do
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
  
  def current_user
    @current_user ||= if cookies[:auth_token]
      token = LoginToken.find_by_token(cookies[:auth_token])
      token ? token.user : User.new
    else
       User.new
    end
  end

end
