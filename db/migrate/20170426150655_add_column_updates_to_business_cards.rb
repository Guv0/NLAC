class AddColumnUpdatesToBusinessCards < ActiveRecord::Migration[5.0]
  def change
    add_column :business_cards, :updates, :jsonb, array:true, default: []
  end
end
