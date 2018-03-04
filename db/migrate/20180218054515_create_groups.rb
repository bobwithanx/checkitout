class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :is_active, default: true

      t.timestamps
    end
    create_table :groups_members, id: false do |t|
      t.belongs_to :groups, index: true
      t.belongs_to :members, index: true
    end
  end
end
