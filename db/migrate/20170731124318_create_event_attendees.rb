class CreateEventAttendees < ActiveRecord::Migration[5.0]
  def change
    create_table :event_attendees do |t|
      t.references :event, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.boolean :attending, default: false

      t.timestamps
    end
  end
end
