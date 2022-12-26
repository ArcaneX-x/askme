# frozen_string_literal: true

require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest.new('SHA256')
  FORMAT_USERNAME = /\A\w+\z/

  attr_accessor :password

  has_many :questions,
           class_name: 'Question',
           foreign_key: :user_id,
           inverse_of: :user,
           dependent: :destroy

  has_many :created_questions,
           class_name: 'Question',
           foreign_key: :author_id,
           inverse_of: :author,
           dependent: :destroy

  before_validation :username_downcase, :email_downcase
  before_save :encrypt_password, if: :password

  validates :username, presence: true,
                       uniqueness: true,
                       length: { maximum: 40 },
                       format: { with: FORMAT_USERNAME }

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password,
            presence: true,
            on: %i[create destroy],
            confirmation: true

  def self.hash_to_string(password_hash)
    password_hash.unpack1('H*')
  end

  def self.authenticate(email, password)
    user = find_by(email:) || find_by(username: email)
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
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(password, password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def username_downcase
    self.username = username.downcase
  end

  def email_downcase
    self.email = email.downcase
  end
end
