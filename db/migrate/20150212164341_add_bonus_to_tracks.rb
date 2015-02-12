class AddBonusToTracks < ActiveRecord::Migration
  def change
    change_table :tracks do |t|
      t.boolean :bonus, default: false
    end
  end
end
