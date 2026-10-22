class AddUsersRefToUserProfile < ActiveRecord::Migration[8.1]
  def change
    add_reference :user_profiles, :user, index: {unique: true}, null: false, foreign_key: true
  end
end
