class TreasureRefinery < Arcane::Refinery
  def update
    treasure_params
  end

  def create
    treasure_params
  end

  private

  def treasure_params
    [
      :title, :description, :tag_list,
      snippets_attributes: [
        :id, :description, :code, :url, :_destroy, :github_path
      ]
    ]
  end
end
