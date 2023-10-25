class AddGroupIdToEntities < ActiveRecord::Migration[7.1]
  def change
    add_reference :entities, :group, null: false, foreign_key: true
  end
end
