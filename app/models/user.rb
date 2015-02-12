class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  after_initialize :ensure_session_token

  has_many :notes,
    class_name: "Note",
    primary_key: :id,
    foreign_key: :user_id,
    dependent: :destroy

  def password
    @password
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = self.find_by(email: email)
    if user == nil
      return nil
    elsif user.is_password?(password)
      return user
    else
      return nil
    end
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.update(session_token: User.generate_session_token)
  end

  def ensure_session_token
    self.session_token ||= reset_session_token!
  end
end
