# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
Gem.find_files('comfy/blog/post').each{|f| require f}
class Comfy::Blog::Post
  belongs_to :author, class_name: 'User'
  validate :author_id, presence: true  
end

