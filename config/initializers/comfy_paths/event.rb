class ActionDispatch::Routing::Mapper

  def comfy_route_event(options = {})
    scope :module => :comfy, :as => :comfy do
      resources :events, :path=>options[:path], :only=>[:index,:show]
    end
  end
end
