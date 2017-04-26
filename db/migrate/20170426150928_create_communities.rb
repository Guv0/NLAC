class CreateCommunities < ActiveRecord::Migration[5.0]
  def change
    create_table :communities do |t|
      t.string :name
      t.text :description
      t.string :photo
      t.references :owner, foreign_key: {to_table: :users}, index: true
      t.references :contacts, foreign_key: {to_table: :users}, index: true
      t.timestamps
    end
  end
end
