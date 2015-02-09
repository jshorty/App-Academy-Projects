class Group < ActiveRecord::Base
  validate :user_id, presence: true

  belongs_to :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  has_many :grouped_contacts,
    class_name: "GroupedContact",
    primary_key: :id,
    foreign_key: :group_id

  has_many :contacts,
    through: :grouped_contacts,
    source: :contact
end
