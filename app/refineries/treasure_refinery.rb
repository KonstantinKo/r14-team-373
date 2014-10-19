class TreasureRefinery < Arcane::Refinery
  def create
    [
      :title, :description, :tag_list,
      snippet_attributes: [
        :id, :description, :code, :url, :_destroy
      ] 
    ]
  end
end
