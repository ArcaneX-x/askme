# frozen_string_literal: true

class Hashtaggable < ApplicationRecord
  belongs_to :question
  belongs_to :hashtag
end
