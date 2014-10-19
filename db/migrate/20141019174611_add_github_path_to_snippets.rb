class AddGithubPathToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :github_path, :string
  end
end
