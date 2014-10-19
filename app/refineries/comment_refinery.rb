class CommentRefinery < Arcane::Refinery
  def create
    [ :content, :treasure_id, snippets_attributes: [
      :id, :description, :code, :url, :_destroy, :github_path
    ]]
  end
end
