class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true} 
  validates :password_digest, presence: true
  validates :session_token, presence: true
  
  after_initialize :ensure_session_token
  
  attr_reader :password
  
  
  has_many :goals
  
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end 
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    return nil unless user.is_password?(password)
    user
  end
  
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
  
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end 
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
    nil
  end 
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
