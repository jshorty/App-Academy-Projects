class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  belongs_to :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id

  has_many :visits,
    class_name: "Visit",
    foreign_key: :url_id,
    primary_key: :id

  has_many :visitors, -> { distinct },
            through: :visits, source: :visitor

  def self.random_code
    code = SecureRandom::urlsafe_base64(16)

    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom::urlsafe_base64(16)
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create! long_url: long_url,
                         submitter_id: user.id,
                         short_url: short_url
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques(time)
    visits.where(created_at < time).select(:visitor_id).count
  end
end
