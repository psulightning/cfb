module ApplicationHelper
  def show_flash_messages
    msg=""
    if !flash.keys.empty?
      flash.each{|k,v|
        msg << content_tag(:div, v, :class=>"flash #{k}")
        flash.delete(k)
      }
    end
    msg.html_safe
  end
end
