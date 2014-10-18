class Comment < ActiveRecord::Base
  has_many :snippets, as: :snippetable
  belongs_to :treasure
end
