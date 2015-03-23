class AddActivationToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :activated, default: false
    end
  end
end
