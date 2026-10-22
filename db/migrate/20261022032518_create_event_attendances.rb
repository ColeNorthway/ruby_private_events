class CreateEventAttendances < ActiveRecord::Migration[8.1]
  def change
    create_table :event_attendances, primary_key: [ :event_id, :attendee_id ] do |t|
      t.integer :event_id, null: false
      t.integer :attendee_id, null: false

      t.timestamps
    end

    add_foreign_key :event_attendances, :users, column: :attendee_id, primary_key: :id
    add_foreign_key :event_attendances, :events, column: :event_id, primary_key: :id
  end
end
