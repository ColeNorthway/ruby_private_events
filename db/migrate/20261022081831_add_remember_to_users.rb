class AddRememberToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :remember, :string
    add_index :users, :remember, unique: true
  end
end
