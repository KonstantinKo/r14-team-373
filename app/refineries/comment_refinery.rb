class CommentRefinery < Arcane::Refinery
  def create
    [:email, :content, :treasure_id]
  end
end
