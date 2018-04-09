
class User < ActiveRecord::Base
  has_many :words
  has_secure_password

end
