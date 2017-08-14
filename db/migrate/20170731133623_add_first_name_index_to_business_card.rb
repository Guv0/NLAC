class AddFirstNameIndexToBusinessCard < ActiveRecord::Migration[5.0]
  def change
    add_index :business_cards, :first_name
  end
end
