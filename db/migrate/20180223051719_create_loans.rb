class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.references :member, foreign_key: true
      t.references :item, foreign_key: true
      t.datetime :returned_at, null: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
