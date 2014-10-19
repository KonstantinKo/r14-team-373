class Comment < ActiveRecord::Base
  # Associations
  has_many :snippets, as: :snippetable
  belongs_to :user, inverse_of: :comments
  belongs_to :treasure, inverse_of: :comments

  # Validations
  validates :content, presence: true, uniqueness: { scope: :treasure }
  validates :email, format: /\A.+@.+\..+\z/, allow_blank: true
  validates :email, presence: true, unless: -> { user }
end
