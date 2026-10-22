class RemoveUsersRefToUserProfile < ActiveRecord::Migration[8.1]
  def change
    remove_reference :user_profiles, :users, foreign_key: true
  end
end
