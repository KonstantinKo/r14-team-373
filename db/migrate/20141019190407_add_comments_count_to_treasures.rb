class AddCommentsCountToTreasures < ActiveRecord::Migration
  def change
    add_column :treasures, :comments_count, :integer
  end
end
