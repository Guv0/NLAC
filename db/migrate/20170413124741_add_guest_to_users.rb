class AddGuestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :guest, :boolean, null: false, default: false
  end
end
