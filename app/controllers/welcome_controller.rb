# To change this template, choose Tools | Templates
# and open the template in the editor.

class WelcomeController < ApplicationController
  
  helper :welcome
  
  def index
    @announcements = Comfy::Cms::Page.find_by_slug("announcements")
    @blog = Comfy::Blog::Blog.find_by_identifier("wod")
    @wod =  @blog.posts.where(["published_at<=?",Time.now.utc]).first
  end
end
