class Treasure < ActiveRecord::Base
  acts_as_taggable

  has_many :snippets, as: :snippetable
  has_many :comments
end
