class Comfy::Admin::MonthAthletesController < Comfy::Admin::Cms::BaseController

  before_action :build_athlete,  :only => [:new, :create]
  before_action :load_athlete,   :only => [:show, :edit, :update, :destroy]

  def index
    @athletes = MonthAthlete.page(params[:page])
  end

  def show
    render
  end

  def new
    render
  end

  def edit
    render
  end

  def create
    build_picture

    @athlete.save!
    flash[:success] = 'Athlete of the Month created'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    add_file_errors
    flash.now[:danger] = 'Failed to create Athlete of the Month'
    render :action => :new
  end

  def update
    build_picture
    
    @athlete.update_attributes!(athlete_params)
    flash[:success] = 'Athlete of the Month updated'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    add_file_errors
    flash.now[:danger] = 'Failed to update Athlete of the Month'
    render :action => :edit
  end

  def destroy
    @athlete.destroy
    flash[:success] = 'Athlete of the Month deleted'
    redirect_to :action => :index
  end

protected

  def build_athlete
    @athlete = MonthAthlete.new(athlete_params)
  end

  def load_athlete
    @athlete = MonthAthlete.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Athlete of the Month not found'
    redirect_to :action => :index
  end

  def build_picture
    picture_file = params[:athlete][:picture]
    if picture_file
      @file = @site.files.new(:file=>picture_file,:label=>picture_file.original_filename)
      @file.save!
      @athlete.picture = @file
    end
  end
  
  def add_file_errors
    @athlete.errors.add(:picture, @file.errors) if @file.errors
  end

  def athlete_params
    params.fetch(:athlete, {}).permit(:name,:month,:year, :description)
  end
end