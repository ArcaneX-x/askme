class RemoveFieldAvatarUrlFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :avatar_url, :string
  end
end
