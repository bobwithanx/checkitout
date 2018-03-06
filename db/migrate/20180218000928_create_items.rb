class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :brand
      t.string :name
      t.string :description
      t.string :serial_number
      t.string :inventory_tag
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
