class User < ApplicationRecord
  validates_presence_of :first_name, :last_name, :password_digest, :email
  validates_uniqueness_of :email
end
