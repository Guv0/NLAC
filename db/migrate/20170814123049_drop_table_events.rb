class DropTableEvents < ActiveRecord::Migration[5.0]
  def change

    drop_table :event_attendees
    drop_table :events
  end
end
