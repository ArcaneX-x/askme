require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  FORMAT_USERNAME = /\A\w+\z/

  attr_accessor :password

  has_many :questions, dependent: :destroy

  before_validation :username_downcase, :email_downcase
  before_save :encrypt_password, if: :password

  validates :username, presence: true,
            uniqueness: true,
            length: {maximum: 40},
            format: {with: FORMAT_USERNAME}

  validates :email, presence: true,
            uniqueness: true,
            format: {with: URI::MailTo::EMAIL_REGEXP}

  validates :password,
            presence: true,
            on: [:create, :destroy],
            confirmation: true

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
  user = find_by(email: email) || find_by(username: email)
  return nil unless user.present?

  hashed_password = User.hash_to_string(
    OpenSSL::PKCS5.pbkdf2_hmac(
      password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
    )
  )

  return user if user.password_hash == hashed_password

  nil
end

  private

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST))
    end
  end

  def username_downcase
    self.username = username.downcase
  end
  def email_downcase
    self.email = email.downcase
  end
end
