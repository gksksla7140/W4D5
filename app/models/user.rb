class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: true

  after_initialize :ensure_session_token
  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end


  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
    self.password_digest
  end


  def create_session_token
    token = SecureRandom.urlsafe_base64(16)
    create_session_token if self.class.exists?(session_token: token)
    token
  end


  def reset_session_token!
    self.session_token = create_session_token
    self.save!
    self.session_token
  end


  private
  def ensure_session_token
    self.session_token ||= create_session_token
  end























end
