class Comfy::MonthAthletesController < ApplicationController
  def index
    @athletes = MonthAthlete.order(:year=>:desc, :month=>:desc)
    
    limit = 10 #hardcoded for now
    
    respond_to do |format|
      format.html do
        @athletes = @athletes.page(params[:page]).per(limit)
      end
    end
  end
  
  def show
    @athlete = MonthAthlete.find(params[:id])
  end
end