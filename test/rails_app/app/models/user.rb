class User < ActiveRecord::Base
  devise :database_authenticatable, :encryptable

  def password_salt
    'no salt'
  end

  def password_salt=(new_salt)
  end
end

