class Album < ActiveRecord::Base
  validate :name, :band_id, :performance presence: true
  validate :performance, inclusion: { in: {"live", "studio"}
  validate :name, uniqueness: { scope: :band_id,
    message: "bands must have uniquely named albums" }

  belongs_to :band,
    class_name: "Band",
    primary_key: :id,
    foreign_key: :band_id

  has_many :tracks,
    class_name: "Track",
    primary_key: :id,
    foreign_key: :album_id,
    dependent: :destroy

end
