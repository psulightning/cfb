class ActionDispatch::Routing::Mapper
  
  def comfy_route_event_admin(options = {})
    scope :module => :comfy, :as => :comfy do
      scope :module => :admin, :path=>options[:path] do
        resources :events, :as => :admin_events, :except => [:show]
      end
    end
  end
end
