class RemoveColumnTagRelation < ActiveRecord::Migration[5.0]
  def change
    remove_column :tag_relations, :creator_type
  end
end
