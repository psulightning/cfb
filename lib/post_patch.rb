module PostPatch
  extend ActiveSupport::Concern
  
  included do
    belongs_to :author, class_name: 'User'
    validates :author_id, presence: true
    
    scope :published, -> {
      where(['published_at<=?',Time.now]).where(:is_published=>true)
    }
  end
end