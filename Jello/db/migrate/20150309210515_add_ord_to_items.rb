class AddOrdToItems < ActiveRecord::Migration
  def change
    add_column :items, :ord, :float, default: 0.0
  end
end
