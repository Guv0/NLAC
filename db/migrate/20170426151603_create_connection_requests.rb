class CreateConnectionRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :connection_requests do |t|
      t.references :user, foreign_key: true, index: true
      t.references :contact, foreign_key: {to_table: :users}, index: true
      t.string :status
      t.timestamps
    end
  end
end
