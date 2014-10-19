class AddSlugToTreasures < ActiveRecord::Migration
  def up
    add_column :treasures, :slug, :string

    Treasure.find_each(&:save)
  end

  def down
    remove_column :treasures, :slug
  end
end
