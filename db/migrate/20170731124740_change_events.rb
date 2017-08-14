class ChangeEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :attendee_ids
  end
end
