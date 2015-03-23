class User < ActiveRecord::Base
  validates :user_name, :password_digest, presence: true
  validates :user_name, uniqueness: true
  validates :password, length: {minimum: 6}, allow_nil: true

  #after_initialize :ensure_session_token

  has_many :cats,
    class_name: "Cat",
    primary_key: :id,
    foreign_key: :user_id

  has_many :cat_rental_requests,
    class_name: 'CatRentalRequest',
    primary_key: :id,
    foreign_key: :user_id

  has_many :sessions,
    class_name: "Session",
    primary_key: :id,
    foreign_key: :user_id

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = self.find_by(user_name: user_name)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  # def reset_session_token!
  #   self.session_token = SecureRandom::urlsafe_base64(16)
  #   self.update(session_token: self.session_token)
  #   self.session_token
  # end
  #
  # private
  #
  # def ensure_session_token
  #   self.session_token ||= reset_session_token!
  # end

end
