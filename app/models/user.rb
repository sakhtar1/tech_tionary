class User < ActiveRecord::Base
  has_many :techs
  has_secure_password
end
