class User < ActiveRecord::Base
  # Associations
  has_many :treasures, inverse_of: :user
  has_many :comments, inverse_of: :user

  # Role concerns
  enum role: [:user, :admin]
  after_initialize if: :new_record? do
    self.role = :user
  end

  # Methods
  def self.create_with_omniauth auth
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.email = auth['info']['email']
      user.nickname = auth['info']['nickname'] || auth['info']['name']
    end
  end
end
