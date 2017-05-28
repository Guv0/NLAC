class CreateCommunityMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :community_messages do |t|
      t.string :title
      t.text :body
      t.references :author, foreign_key: {to_table: :users}, index: true
      t.references :community, foreign_key: true, index: true

      t.timestamps
    end
  end
end
