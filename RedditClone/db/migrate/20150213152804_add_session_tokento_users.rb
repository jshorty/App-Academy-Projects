class AddSessionTokentoUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :session_token, null: false
    end

    add_index :users, :session_token, unique: true
  end
end
