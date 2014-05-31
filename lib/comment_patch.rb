# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module CommentPatch
  extend ActiveSupport::Concern
  
  included do
    _validate_callbacks.clear
    belongs_to :author, :class_name=>"User"
    validates :author_id,:content,:post_id, :presence=>true
  end
end


