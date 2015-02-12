class AddPerformanceToAlbums < ActiveRecord::Migration
  def change
    change_table :albums do |t|
      t.string :performance, null: false
    end
  end
end
