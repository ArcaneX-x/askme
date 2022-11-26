class Question < ApplicationRecord
  belongs_to :user,
             class_name: 'User',
             foreign_key: :user_id

  belongs_to :author,
             class_name: 'User',
             foreign_key: :author_id,
             optional: true

  validates :text, :user, presence: true
end
