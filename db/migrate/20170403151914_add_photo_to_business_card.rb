class AddPhotoToBusinessCard < ActiveRecord::Migration[5.0]
  def change
    add_column :business_cards, :photo, :string
  end
end
