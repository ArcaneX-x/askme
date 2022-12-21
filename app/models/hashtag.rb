class Hashtag < ApplicationRecord
  REGEXP = /#[[:word:]-]+/
  has_many :questions, dependent: :destroy
  validates :text, presence: true, length: { maximum: 30}, uniqueness: true


end
