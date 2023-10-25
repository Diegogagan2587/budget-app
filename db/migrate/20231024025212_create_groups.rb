class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :icon
      t.timestamps
    end
  end
end
