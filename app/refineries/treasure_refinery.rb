class TreasureRefinery < Arcane::Refinery
  def create
    [
      :title, :description, :tag_list,
      snippets_attributes: [
        :id, :description, :code, :url, :_destroy, :github_path
      ]
    ]
  end
end
