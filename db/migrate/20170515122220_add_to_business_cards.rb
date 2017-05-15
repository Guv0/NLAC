class AddToBusinessCards < ActiveRecord::Migration[5.0]
  def change
    add_column :business_cards, :position, :string
  end
end
