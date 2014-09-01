require "bcrypt"

class User < ActiveRecord::Base
  
  has_many :posts, class_name: "Blog::Post", foreign_key: "author_id"
  has_many :comments, class_name: "Blog::Comment", foreign_key: "author_id"
  
  STATUS_ANON = 0
  STATUS_LOCKED = 1
  STATUS_MEMBER = 2
  STATUS_COACH = 3
  STATUS_ADMIN = 4
  
  #before_save :change_password
  before_create :salt_password
  
  validates :password, :confirmation=>true, :presence=>true
  validates :login, :uniqueness=>true, :presence=>true
  
  def initialize
    super
    self.permission=STATUS_ANON
    return self
  end
  
  def change_password
    if self.password
      salt_password(self.password)
    end
  end
  
  def to_s
    "#{first} #{last}"
  end
  
  def admin?
    permission>STATUS_MEMBER
  end
  
  def anon?
    permission==STATUS_ANON
  end
  
  def logged?
    !anon?
  end
  
  def locked?
    permission==STATUS_LOCKED
  end
  
  def match_password?(clear_password)
    BCrypt::Engine.hash_secret(clear_password, self.salt) == self.password
  end
  
  def salt_password
    self.salt = BCrypt::Engine.generate_salt
    self.password = BCrypt::Engine.hash_secret(password, self.salt)
  end
  
  def self.try_to_login(name, password)
    user = where(login: name).first
    if user
      return nil unless user.match_password?(password)
    else
      return nil
    end
    user
  end
  
  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end


