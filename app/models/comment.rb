class Comment < ActiveRecord::Base
  # Associations
  has_many :snippets, as: :snippetable
  belongs_to :treasure
end
