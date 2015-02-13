class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true

  belongs_to :moderator,
    class_name: "User",
    primary_key: :id,
    foreign_key: :moderator_id

  has_many :posts,
    class_name: "Post",
    primary_key: :id,
    foreign_key: :id,
    dependent: :destroy

end
