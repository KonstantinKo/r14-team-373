class Comment < ActiveRecord::Base
  # Associations
  has_many :snippets, as: :snippetable
  belongs_to :user, inverse_of: :comments
  belongs_to :treasure, inverse_of: :comments

  # Validations
  validates :content, presence: true
  accepts_nested_attributes_for :snippets, :reject_if => :all_blank, :allow_destroy => true
end
