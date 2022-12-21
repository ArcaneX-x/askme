class CreateHashtags < ActiveRecord::Migration[7.0]
  def change
    create_table :hashtags do |t|
      t.string :text
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
