class CreateCommunities < ActiveRecord::Migration[5.0]
  def change
    create_table :communities do |t|
      t.string :name
      t.text :description
      t.string :photo
      t.timestamps
    end
  end
end
