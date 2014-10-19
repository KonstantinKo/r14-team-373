class Treasure < ActiveRecord::Base
  attr_accessor :unearthing

  # Tagging
  acts_as_taggable

  # Associations
  has_many :snippets, as: :snippetable, counter_cache: true
  has_many :comments, inverse_of: :treasures
  belongs_to :user, inverse_of: :treasures

  # Validations
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :user, presence: true, if: :unearthing

  # Search
  update_index 'treasures#treasure', :self

  # Methods

  def tags_string
    tag_list.join(', ')
  end
end
