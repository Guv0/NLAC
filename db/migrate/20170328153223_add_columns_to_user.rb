class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :industry, :string
    add_column :users, :location, :string
    add_column :users, :linkedin_profile_url, :string
    add_column :users, :phone, :string
    add_column :users, :description, :text
  end
end
