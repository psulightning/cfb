after :comfy_cms_sites do
Comfy::Blog::Blog.create!([
  {"id"=>"1", "site_id"=>"1", "label"=>"WOD", "identifier"=>"wod", "app_layout"=>"application", "path"=>"wod", "description"=>"WOD blog"},
  {"id"=>"2", "site_id"=>"1", "label"=>"Nutrition", "identifier"=>"nutrition", "app_layout"=>"application", "path"=>"nutrition", "description"=>nil},
  {"id"=>"3", "site_id"=>"1", "label"=>"Events", "identifier"=>"events", "app_layout"=>"application", "path"=>"events", "description"=>nil}]
)
end