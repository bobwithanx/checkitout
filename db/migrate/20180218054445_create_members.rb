class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :id_number
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
