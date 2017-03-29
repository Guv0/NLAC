class RemoveColumnsFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :description
    remove_column :users, :linkedin_picture_url
    remove_column :users, :linkedin_profile_url
    remove_column :users, :phone
    remove_column :users, :industry
    remove_column :users, :location
  end
end
