# frozen_string_literal: true

class HashtagQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :hashtag
end
