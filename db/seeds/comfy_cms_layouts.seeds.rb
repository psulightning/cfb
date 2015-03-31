after :comfy_cms_sites do
Comfy::Cms::Layout.create!(
  {"id"=>"1", "site_id"=>"1", "parent_id"=>"NULL", "app_layout"=>"application", "label"=>"default",
    "identifier"=>"default", "content"=>"{{ cms:page:content:rich_text }}", "css"=>nil, "js"=>nil, "position"=>"0",
    "is_shared"=>"0", "created_at"=>"2013-10-24 22:17:49", "updated_at"=>"2013-11-24 20:00:59"}
)
end
