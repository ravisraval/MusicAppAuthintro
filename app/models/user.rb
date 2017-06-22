class User < ApplicationRecord
  validates :email, :password_digest, :session_token, presence: true

  after_initialize :ensure_session_token

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil unless user
    user.valid_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def valid_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


end
