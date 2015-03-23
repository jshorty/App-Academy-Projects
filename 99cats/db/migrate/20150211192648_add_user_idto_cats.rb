class AddUserIdtoCats < ActiveRecord::Migration
  def change
    change_table(:cats) do |t|
      t.integer :user_id
    end

    add_index :cats, :user_id, unique: true
  end
end
