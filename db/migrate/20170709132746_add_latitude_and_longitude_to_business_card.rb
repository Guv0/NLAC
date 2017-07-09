class AddLatitudeAndLongitudeToBusinessCard < ActiveRecord::Migration[5.0]
  def change
    add_column :business_cards, :latitude, :float
    add_column :business_cards, :longitude, :float
  end
end
