class User < ApplicationRecord
  validates_presence_of :password
  validates_uniqueness_of :email, :api_key
  
  has_secure_password
end