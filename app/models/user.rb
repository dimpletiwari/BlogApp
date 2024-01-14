class User < ApplicationRecord
  has_secure_password
  has_many :posts
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, on: :create

  enum role: { user: 'user', admin: 'admin' }
  def generate_auth_token
    self.auth_token = SecureRandom.hex
    save
    auth_token
  end
end
