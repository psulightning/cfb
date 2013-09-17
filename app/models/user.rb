require "bcrypt"

class User < ActiveRecord::Base
  
  STATUS_ANON = 0
  STATUS_MEMBER = 1
  STATUS_COACH = 2
  STATUS_ADMIN = 3
  STATUS_LOCKED = 4
  
  before_save :change_password
  
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
  
  
  def self.current=(user)
    Thread.current[:current_user] = user	
  end
  
  def self.current	
    Thread.current[:current_user] ||= User.new
  end
  
  def to_s
    "#{first} #{last} (#{login})"
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
  
  def match_password?(clear_password)
    BCrypt::Engine.hash_secret(clear_password, self.salt) == self.password
  end
  
  def salt_password(clear_password)
    self.salt = BCrypt::Engine.generate_salt
    self.password = BCrypt::Engine.hash_secret(clear_password, self.salt)
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
end


