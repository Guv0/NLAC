class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :subject
      t.datetime :last_message
      t.references :sender, foreign_key: {to_table: :users}, index: true
      t.references :recipient, foreign_key: {to_table: :users}, index: true
      t.boolean :trash, default: false
      t.timestamps
    end
  end
end
