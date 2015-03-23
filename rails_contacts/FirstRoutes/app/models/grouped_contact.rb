class GroupedContact < ActiveRecord::Base
    validate :group_id, :contact_id, presence: true

    belongs_to :group,
      class_name: "Group",
      primary_key: :id,
      foreign_key: :group_id

    belongs_to :contact,
      class_name: "Contact",
      primary_key: :id,
      foreign_key: :contact_id
end
