class CreateGroupedContacts < ActiveRecord::Migration
  def change
    create_table :grouped_contacts do |t|
      t.integer :group_id, null: false
      t.integer :contact_id, null: false
      t.timestamps
    end

    add_index(:grouped_contacts, :group_id)
    add_index(:grouped_contacts, :contact_id)
  end
end
