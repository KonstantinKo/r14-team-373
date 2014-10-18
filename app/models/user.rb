class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def create_with_omniauth
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
    end
  end

end
