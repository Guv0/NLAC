class ChangeColumnAttendeesInEvents < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :attendees_id, :attendee_ids
  end
end
