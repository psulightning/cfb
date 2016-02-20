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

  def options_for_month_select
    [["Jan", 1],["Feb", 2],["Mar", 3],["Apr", 4],["May", 5],["Jun", 6],["July", 7],["Aug", 8],["Sep", 9],["Oct", 10],["Nov", 11],["Dec", 12]]
  end
  
  def right_sidebar
    @aotm = MonthAthlete.get_latest
    @events = Event.get_latest
  end
  
  def cleanup_description(str)
    str = strip_tags(str)
    str.gsub!("&amp;", "&")
    str.gsub!("&nbsp;", "")
    truncate(str, length: 75)
  end
  
  def prepare_menu_bar
    @pages = Rails.cache.fetch('menu_bar_pages', :expires_in => 30) do 
      Comfy::Cms::Page.published.where(:is_menu_bar => true, :parent_id => Comfy::Cms::Page.root.id).where.not(:slug => "announcements") 
    end
  end
  
  def menu_bar_builder(page)
    if page.children.present?
      if page.parent == Comfy::Cms::Page.root
        drop_down page.label do
          page.children.collect do |c|
            menu_bar_builder(c)
          end.join("").html_safe
        end
      else
        drop_down_submenu page.label do
          page.children.collect do |c|
            menu_bar_builder(c)
          end.join("").html_safe
        end
      end
    else
      menu_item page.label, comfy_cms_render_page_url(page.url)
    end
  end
end