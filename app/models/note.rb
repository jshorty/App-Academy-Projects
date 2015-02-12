class Note < ActiveRecord::Base
  validate :text, :user_id, :track_id, presence: true
  validate :text, length: { minimum: 1 }

  belongs_to :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :track,
    class_name: "Track",
    primary_key: :id,
    foreign_key: :track_id
end
