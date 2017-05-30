class CreateCommunityRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :community_requests do |t|
      t.references :user, foreign_key: true, index: true
      t.references :community, foreign_key: true, index: true
      t.string :status

      t.timestamps
    end
  end
end
