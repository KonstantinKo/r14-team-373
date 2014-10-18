class User < ActiveRecord::Base
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def self.create_with_omniauth auth
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.email = auth['email']
    end
  end

  def set_default_role
    self.role = :user
  end

end
