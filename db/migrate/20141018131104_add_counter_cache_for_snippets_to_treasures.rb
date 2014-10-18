class AddCounterCacheForSnippetsToTreasures < ActiveRecord::Migration
  def self.up
    add_column :treasures, :snippets_count, :integer, null:false, default: 0

    Treasure.all.each do |treasure|
      treasure.snippets_count = treasure.snippets.count
      treasure.save
    end
  end

  def self.down
    remove_column :nominations, :comments_count
  end
end
