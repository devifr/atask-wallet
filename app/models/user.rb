class User < ApplicationRecord
  has_one :wallet, as: :walletable
  has_many :transactions

  # Include bcrypt functionality
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
