class User < ApplicationRecord
  has_secure_password
  has_many :posts
  def generate_auth_token
    self.auth_token = SecureRandom.hex
    save
    auth_token
  end
end
