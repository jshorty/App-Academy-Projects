class Comment < ActiveRecord::Base
  validate :author_id, :body, presence: true

  belongs_to :author,
    class_name: "User",
    primary_key: :id,
    foreign_key: :author_id

  belongs_to :commentable,
    :polymorphic => true,
    class_name: :commentable_type,
    foreign_key: :commentable_id,
    primary_key: :id
end
