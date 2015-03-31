# To change this template, choose Tools | Templates
# and open the template in the editor.

class WelcomeController < ApplicationController
  
  helper :welcome
  
  def index
    @announcements = Comfy::Cms::Page.find_by_slug("announcements")
    @files = Comfy::Cms::File.includes(:categories).for_category("front")
    wod_blog = Comfy::Blog::Blog.find_by_identifier("wod")
    @wods =  wod_blog.posts.where(["published_at<=?",Time.now.utc]).first(4)
  end
end
