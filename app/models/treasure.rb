class Treasure < ActiveRecord::Base
  # Tagging
  acts_as_taggable

  # Associations
  has_many :snippets, as: :snippetable, counter_cache: true
  has_many :comments

  # Validations
  validates :title, presence: true
  validates :description, presence: true

  # Search
  update_index 'treasures#treasure', :self

  # Methods

  def tags_string
    tag_list.join(', ')
  end
end
