class AddUserIdToTreasures < ActiveRecord::Migration
  def change
    add_column :treasures, :user_id, :integer
  end
end
