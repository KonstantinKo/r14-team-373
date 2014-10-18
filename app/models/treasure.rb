class Treasure < ActiveRecord::Base
  # Tagging
  acts_as_taggable

  # Associations
  has_many :snippets, as: :snippetable
  has_many :comments

  # Validations
  validates :title, presence: true
  validates :description, presence: true

  # Search
  update_index 'treasures#treasure', :self
end
