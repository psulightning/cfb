# To change this template, choose Tools | Templates
# and open the template in the editor.

module AdminPostsHelper
  unloadable
   def author_field
     hidden_field_tag("post[author_id]", current_user.id)+
     content_tag(:div, :class=>"form_group")do
       content_tag(:label, "Author", :class=>"control-label col-sm-2")+
       (content_tag(:div, :class=>"col-sm-10") do 
         content_tag(:p, current_user.to_s, :class=>"form-control-static")
       end)
     end
   end 
end
