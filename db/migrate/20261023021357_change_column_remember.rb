class ChangeColumnRemember < ActiveRecord::Migration[8.1]
  def change
    change_column :users, :remember, :integer
  end
end
