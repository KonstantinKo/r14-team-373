class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :snippetable_type
      t.integer :snippetable_id
      t.string :link
      t.text :code

      t.timestamps
    end
  end
end
