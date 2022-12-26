# frozen_string_literal: true

class Hashtag < ApplicationRecord
  REGEXP_H = /#[[:word:]:?-]+/

  has_many :hashtaggables, dependent: :destroy
  has_many :questions, through: :hashtaggables

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
end
