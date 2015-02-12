class ChangeActivationTokeninUsers < ActiveRecord::Migration
  def change
    change_column :users, :activation_token, :string
  end
end
