class Comfy::EventsController < ApplicationController
  
  def index
    @events = Event.descend_date
    
    limit = 10 #hardcoded for now
    
    respond_to do |format|
      format.html do
        @events = @events.page(params[:page]).per(limit)
      end
    end
  end
  
  def show
    @event = Event.find(params[:id])
  end
end
