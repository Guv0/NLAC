class CreateTagRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_relations do |t|
      t.references :business_card, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
      t.integer :creator_id
      t.string :creator_type
      t.timestamps
    end
  end
end
