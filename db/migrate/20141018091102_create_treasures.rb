class CreateTreasures < ActiveRecord::Migration
  def change
    create_table :treasures do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
