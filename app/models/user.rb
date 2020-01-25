class User < ApplicationRecord
attr_accessor :password
  validates_confirmation_of :password
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  before_save :encrypt_password

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
  end

  def self.authenticate(input, password)
  email = User.find_by "email = ?", input
  username = User.find_by "username = ?", input
  if email
    user = email
  else
    user = username
  end
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
