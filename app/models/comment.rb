class Comment < ActiveRecord::Base
  validates :post_id, :author_id, :content, presence: true

  belongs_to :post,
    class_name: "Post",
    primary_key: :id,
    foreign_key: :post_id

  belongs_to :author,
    class_name: "User",
    primary_key: :id,
    foreign_key: :author_id
end
