class AddForeignKeyBusinessCard < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :business_cards, :users
  end
end
