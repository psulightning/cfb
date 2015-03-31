class ActionDispatch::Routing::Mapper

  def comfy_route_month_athlete(options = {})
    scope :module => :comfy, :as => :comfy do
      resources :month_athletes, :path=>options[:path], :as=>:aotms, :only=>[:index,:show]
    end
  end
end
