class AddIndexTotalPts < ActiveRecord::Migration
  def change
    add_index :total_karma_pts, :user_id
  end
end
