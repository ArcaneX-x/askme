# frozen_string_literal: true

class Hashtag < ApplicationRecord
  REGEXP_H = /#[[:word:]:-]+/

  has_many :hashtag_questions, dependent: :destroy
  has_many :questions, through: :hashtag_questions

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
end
