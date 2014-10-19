class Treasure < ActiveRecord::Base
  # Attrs
  attr_accessor :unearthing

  # Slug
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Tagging
  acts_as_taggable

  # Associations
  has_many :snippets, as: :snippetable, counter_cache: true
  has_many :comments, inverse_of: :treasure
  belongs_to :user, inverse_of: :treasures

  # Validations
  validates :title, presence: true, uniqueness: true
  validates :user, presence: true, if: :unearthing

  # Search
  update_index 'treasures#treasure', :self

  # Methods

  def tags_string
    tag_list.join(', ')
  end
end
