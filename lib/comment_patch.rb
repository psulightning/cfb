module CommentPatch
  extend ActiveSupport::Concern
  
  included do
    _validate_callbacks.clear
    belongs_to :author, :class_name=>"User"
    validates :author_id,:content,:post_id, :presence=>true
  end
end


