class Question < ApplicationRecord
  has_many :hashtags

  belongs_to :user,
             class_name: 'User',
             foreign_key: :user_id

  belongs_to :author,
             class_name: 'User',
             foreign_key: :author_id,
             optional: true

  validates :text, :user, presence: true

  after_commit :create_hashtags, on: [:create, :update]

  private

  def create_hashtags
  end
end
