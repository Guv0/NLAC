class CreateCommunityMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :community_memberships do |t|
      t.references :member, foreign_key: {to_table: :users}, index: true
      t.references :community, foreign_key: true, index: true
      t.boolean :owner, default: false
      t.timestamps
    end
  end
end
