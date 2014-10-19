class Vote < ActiveRecord::Base
  # Associations
  belongs_to :treasure, inverse_of: :votes, counter_cache: true
  belongs_to :user, inverse_of: :votes

  # Validations
  validates :treasure, uniqueness: { scope: :user }
  validates :user, uniqueness: { scope: :treasure }
end
