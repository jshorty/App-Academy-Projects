class AddUserIDtoCatRentalRequests < ActiveRecord::Migration
  def change
    change_table(:cat_rental_requests) do |t|
      t.integer :user_id, null: false
    end
  end
end
