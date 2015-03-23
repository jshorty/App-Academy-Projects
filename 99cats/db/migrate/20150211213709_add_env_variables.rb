class AddEnvVariables < ActiveRecord::Migration
  def change
    change_table :sessions do |t|
      t.string :env, null: false
      t.string :ip, null: false
    end
  end
end
