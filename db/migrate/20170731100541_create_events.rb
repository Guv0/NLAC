class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.references :community, index: true, foreign_key: true
      t.references :organiser, index: true, foreign_key: {to_table: :users}
      t.references :attendees, index: true, foreign_key: {to_table: :users}
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
