module PostPatch
  extend ActiveSupport::Concern
  
  included do
    belongs_to :author, class_name: 'User'
    validate :author_id, presence: true  
  end
end

