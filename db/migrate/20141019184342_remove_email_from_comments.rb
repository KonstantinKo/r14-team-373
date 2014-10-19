class RemoveEmailFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :email, :string
  end
end
