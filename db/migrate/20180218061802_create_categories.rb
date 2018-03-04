class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :icon

      t.timestamps
    end

    create_table :categories_items, id: false do |t|
      t.belongs_to :category, index: true
      t.belongs_to :item, index: true
    end
  end
end
