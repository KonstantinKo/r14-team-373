class Snippet < ActiveRecord::Base
  # Associations
  belongs_to :snippetable

  def github?
    github_path.present? || !code.present?
  end
end
