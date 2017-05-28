class CreateCommunityMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :community_messages do |t|
      t.string :title
      t.text :body
      t.references :user, foreign_key: true
      t.references :community, foreign_key: true

      t.timestamps
    end
  end
end
