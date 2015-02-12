class AddActivationTokenToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :activation_token
    end
  end
end
