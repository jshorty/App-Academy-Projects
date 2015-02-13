class Post < ActiveRecord::Base
  validates :title, :sub_ids, :author_id, presence: true
  validates :sub_ids, length: {minimum: 1}

  has_many :post_subs,
    class_name: "PostSub",
    primary_key: :id,
    foreign_key: :post_id

  has_many :subs,
    through: :post_subs,
    source: :sub

  belongs_to :author,
    class_name: "User",
    primary_key: :id,
    foreign_key: :author_id

end
