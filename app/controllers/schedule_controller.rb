# To change this template, choose Tools | Templates
# and open the template in the editor.

class ScheduleController < ApplicationController
  def index
    render layout: false
  end
  
  def events
    mindbody
  end
  
  private
  def mindbody
    curr_date = Date.today
    min = params[:min] || Date.new(curr_date.year(),curr_date.month(),1)
    max = params[:max] || Date.new(curr_date.year(),curr_date.month(),-1)

    service = MindBody::Services::ClassService.new
    dates = {"StartDateTime"=>min.to_date,
      "EndDateTime"=>max.to_date}
    response = service.get_classes(dates)
    classes = response.result[:classes]
    @class_list = []
    classes.each{|c|
      hsh = {}
      hsh[:id]=c.id
      hsh[:text]=c.name
      hsh[:details]=c.class_description.description.gsub(/\<div\>|\<\/div\>/,"")
      hsh[:start_date] = c.start_date_time.strftime('%m/%d/%Y %l:%M %p')
      hsh[:end_date] = c.end_date_time.strftime('%m/%d/%Y %l:%M %p')
      hsh[:staff]=c.staff.name
      hsh[:color] = case c.name
      when "Open Gym"
        "green"
      when /CrossFit/
        "blue"
      when "Seminar"
        "orange"
      else
        "purple"
      end
      hsh[:color] = "red" if c.is_canceled?
      if mobile_device?
        hsh[:textColor] = hsh[:color]
        hsh[:color] = "white"
      end
      @class_list << hsh
    }
    render :json => @class_list
  end
end
