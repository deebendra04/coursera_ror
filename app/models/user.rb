class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 6 }
  validates :role, presence: true, inclusion: { in: %w[student instructor admin] }
end
