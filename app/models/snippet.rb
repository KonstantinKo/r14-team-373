class Snippet < ActiveRecord::Base
  # Associations
  belongs_to :snippetable, polymorphic: true
  update_index 'treasures#treasure', :snippetable 

  def github?
    github_path.present? || !code.present?
  end
end
