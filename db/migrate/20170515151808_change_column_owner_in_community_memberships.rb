class ChangeColumnOwnerInCommunityMemberships < ActiveRecord::Migration[5.0]
  def change
    rename_column :community_memberships, :owner, :manager
  end
end
