class AddColumnEmailToBusinessCards < ActiveRecord::Migration[5.0]
  def change
    add_column :business_cards, :email, :string
  end
end
