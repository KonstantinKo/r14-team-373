class AddVotesCountToTreasures < ActiveRecord::Migration
  def change
    add_column :treasures, :votes_count, :integer, default: 0
  end
end
