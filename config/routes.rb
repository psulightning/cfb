Baltbear::Application.routes.draw do
  namespace :admin do
    resources :month_athletes
  end

  root :to => "welcome#index"
  get "contact", :to=>"contact#index"
  post "contact", :to=>"contact#send_mail"
  resources :users, :only=>[:edit,:update,:show] do
    resources :journals
  end
  
  match "register", :to=>"users#register", :as=>:register, :via=>[:post,:get]
  get "profile", :to=>"users#profile", :as=>:profile
  
  resources :exercises, :except=>[:index,:show]

  get "signin", :to=>"account#index", :as=>:signin
  post "login", :to=>"account#login", :as=>:login
  
  get "logout", :to=>"account#logout", :as=>:logout
  match "checkin", :to=>"account#checkin", :via=>[:post,:get]
  
  match "schedule", :to=>"schedule#index", :via=>[:post,:get]
  get "schedule/events.js", :to=>"schedule#events", :via=>[:get]
  
  comfy_route :event_admin, :path => '/cms-admin'
  comfy_route :event, :path => "/events"
  
  comfy_route :month_athlete_admin, :path => '/cms-admin'
  comfy_route :month_athlete, :path => "/aotm"
  
  comfy_route :blog_admin, :path => '/cms-admin'
  comfy_route :blog, :path => '/blog'
  
  comfy_route :cms_admin, :path => '/cms-admin'
  comfy_route :cms, :path => '/', :sitemap => false
end
