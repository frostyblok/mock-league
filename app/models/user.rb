# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  before_validation :set_default_role!

  validates_presence_of :first_name, :last_name, :password_digest, :email
  validates_uniqueness_of :email
  validates :role, inclusion: { in: %w[user admin] }

  private

  def set_default_role!
    self.role = 'user' if role == ''
  end
end
