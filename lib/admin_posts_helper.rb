# To change this template, choose Tools | Templates
# and open the template in the editor.

module AdminPostsHelper
  unloadable
   def author_field
     hidden_field_tag("posts[author_id]", current_user.id)+
     content_tag(:div, :class=>"form_group")do
       (content_tag(:label, :class=>"control-label col-sm-2") do "Author"; end)+
       (content_tag(:div, :class=>"col-sm-10") do 
         current_user.to_s
       end)
     end
   end 
end
