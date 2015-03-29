class ActionDispatch::Routing::Mapper
  
  def comfy_route_month_athlete_admin(options = {})
    scope :module => :comfy, :as => :comfy do
      scope :module => :admin, :path=>options[:path] do
        resources :month_athletes, :as => :admin_athletes, :except => [:show]
      end
    end
  end
end
