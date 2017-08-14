class DropTableEventAttendees < ActiveRecord::Migration[5.0]
  def change
    drop_table :table_event_attendees
  end
end
