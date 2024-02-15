class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true,
    format: { with: /\A(\S+)@(.+)\.(\S+)\z/ }
  validates :password, length: { minimum: 5 }, presence: true

  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
end
