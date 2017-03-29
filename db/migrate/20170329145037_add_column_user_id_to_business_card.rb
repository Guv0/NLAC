class AddColumnUserIdToBusinessCard < ActiveRecord::Migration[5.0]
  def change
    add_reference :business_cards, :user, index: true
  end
end
