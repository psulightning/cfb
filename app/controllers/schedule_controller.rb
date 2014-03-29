# To change this template, choose Tools | Templates
# and open the template in the editor.

class ScheduleController < ApplicationController
  def index
    year = params[:year] || Date.today.year
    month = params[:month] || Date.today.month
    client = ClassService.new
    dates = {"StartDateTime"=>Date.civil(year,month,1),
      "EndDateTime"=>Date.civil(year,month,-1)}
    response = client.get_classes(dates)
    classes = []
    response.xpath("//Classes").children.each{|c|
      class_hash={}
      class_hash[:name]=c.xpath("ClassDescription/Name").inner_text
      class_hash[:description]=c.xpath("ClassDescription/Description").inner_text
      class_hash[:start]=c.xpath("StartDateTime").inner_text.strftime("%m/%d/%Y %H:%M")
      class_hash[:staff]=c.xpath("Staff/Name").inner_text
    }
    
  end
end
