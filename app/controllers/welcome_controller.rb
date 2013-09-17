# To change this template, choose Tools | Templates
# and open the template in the editor.

class WelcomeController < ApplicationController
  
  helper :welcome
  
  def index
    @files = Cms::File.includes(:categories).for_category("front")
  end
end
