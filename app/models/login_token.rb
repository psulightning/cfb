require "bcrypt"

class LoginToken < ActiveRecord::Base
  belongs_to :user
  
  def initialize(args)
    super
    self.token = SecureRandom.urlsafe_base64
    self.last_accessed = Time.now
  end
  
  after_find do
    self.last_accessed = Time.now
    save!
  end
end
