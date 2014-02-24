class AddTotalPtsTable < ActiveRecord::Migration
  def change
    create_table :total_karma_pts do |t|
      t.integer :total_karma
      t.references :user
      t.timestamps
    end
  end
end
