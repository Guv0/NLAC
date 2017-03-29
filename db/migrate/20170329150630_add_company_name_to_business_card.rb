class AddCompanyNameToBusinessCard < ActiveRecord::Migration[5.0]
  def change
    add_column :business_cards, :company_name, :string
  end
end
