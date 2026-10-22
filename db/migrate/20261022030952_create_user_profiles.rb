class CreateUserProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :user_profiles do |t|
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.boolean :gender
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.references :users, index: {unique: true}, null: false, foreign_key: true

      t.timestamps
    end
  end
end
