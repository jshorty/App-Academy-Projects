class AddFavoriteToContacts < ActiveRecord::Migration
  def change
    change_table :contacts do |t|
      t.boolean :favorite
    end

    change_table :contact_shares do |t|
      t.boolean :favorite
    end
  end
end
