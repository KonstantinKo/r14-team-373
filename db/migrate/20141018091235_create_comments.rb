class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :treasure_id
      t.string :email
      t.text :content
      t.boolean :notify

      t.timestamps
    end
  end
end
