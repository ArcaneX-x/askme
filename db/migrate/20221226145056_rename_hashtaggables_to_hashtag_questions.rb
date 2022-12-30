class RenameHashtaggablesToHashtagQuestions < ActiveRecord::Migration[7.0]
  def change
    rename_table :hashtaggables, :hashtag_questions
  end
end
