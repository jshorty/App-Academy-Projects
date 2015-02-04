class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  def self.random_code
    code = SecureRandom::urlsafe_base64(16)

    while ShortenedUrl.where(short_url: code).empty?
      code = SecureRandom::urlsafe_base64(16)
    end
  end
end
