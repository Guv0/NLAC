class CreateBusinessCards < ActiveRecord::Migration[5.0]
  def change
    create_table :business_cards do |t|
      t.string :first_name
      t.string :last_name
      t.string :location
      t.string :phone
      t.string :industry
      t.string :linkedin_profile_url
      t.string :linkedin_picture_url
      t.text :description
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end
end
