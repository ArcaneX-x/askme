class CreateHashtaggables < ActiveRecord::Migration[7.0]
  def change
    create_table :hashtaggables do |t|
      t.belongs_to :question, null: false, foreign_key: true
      t.belongs_to :hashtag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
