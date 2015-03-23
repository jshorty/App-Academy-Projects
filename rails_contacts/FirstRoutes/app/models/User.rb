class User < ActiveRecord::Base
  validates :username, :presence => true
  validates :username, :uniqueness => true

  has_many :contacts,
    class_name: "Contact",
    primary_key: :id,
    foreign_key: :user_id

  has_many :contact_shares,
    class_name: "ContactShare",
    primary_key: :id,
    foreign_key: :user_id,
    :dependent => :destroy

  has_many :shared_contacts,
    through: :contact_shares,
    source: :contact

  has_many :comments,
    as: :commentable,
    class_name: "Comment",
    foreign_key: :commentable_id,
    primary_key: :id

  has_many :authored_comments,
    class_name: "Comment",
    primary_key: :id,
    foreign_key: :author_id

  has_many :groups,
    class_name: "Group",
    primary_key: :id,
    foreign_key: :user_id
end
