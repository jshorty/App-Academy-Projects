class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visitor_id
      t.integer :url_id

      t.timestamps
    end

    add_index :visits, :visitor_id, name: 'visitor_id_index'
    add_index :visits, :url_id, name: 'url_id_index'
  end
end
