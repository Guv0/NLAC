class CreateTableEventAttendees < ActiveRecord::Migration[5.0]
  def change
    create_table :event_attendees do |t|
      t.references :event, foreign_key: true, index: true
      t.references :attendee, foreign_key: {to_table: :users}, index: true
      t.boolean :attending, default: false
      t.boolean :organiser, default: false

      t.timestamps
    end
  end
end
