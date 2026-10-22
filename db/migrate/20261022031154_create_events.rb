class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.date :date, null: false
      t.string :location, null: false
      t.integer :host_id, null: false

      t.timestamps
    end

    add_foreign_key :events, :users, column: :host_id, primary_key: :id
    add_index :events, :name, unique: true
  end
end
