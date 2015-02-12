class Track < ActiveRecord::Base
  validate :name, :album_id, presence: true
  validate :name, uniqueness: { scope: :album_id,
    message: "albums must have uniquely named tracks" }

  belongs_to :album,
    class_name: "Album",
    primary_key: :id,
    foreign_key: :album_id

  has_one :band,
    through: :album,
    source: :band

end
