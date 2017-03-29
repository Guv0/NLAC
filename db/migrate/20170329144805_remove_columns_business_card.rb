class RemoveColumnsBusinessCard < ActiveRecord::Migration[5.0]
  def change
    remove_column :business_cards, :owner_id
    remove_column :business_cards, :owner_type
  end
end
