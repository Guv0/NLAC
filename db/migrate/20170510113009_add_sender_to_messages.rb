class AddSenderToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :sender, :string
    add_column :conversations, :started_on, :string
  end
end
