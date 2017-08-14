class CreateTableEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.references :community, index: true, foreign_key: true
      t.string :address
      t.string :postcode
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
