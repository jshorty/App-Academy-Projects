class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true

  belongs_to :moderator,
    class_name: "User",
    primary_key: :id,
    foreign_key: :moderator_id

  has_many :post_subs,
    class_name: "PostSub",
    primary_key: :id,
    foreign_key: :sub_id

  has_many :posts,
    through: :post_subs,
    source: :post

end
