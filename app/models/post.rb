class Post < ActiveRecord::Base
  validates :title, :author_id, :sub_id, presence: true

  belongs_to :sub,
    class_name: "Sub",
    primary_key: :id,
    foreign_key: :sub_id

  belongs_to :author,
    class_name: "User",
    primary_key: :id,
    foreign_key: :author_id
end
