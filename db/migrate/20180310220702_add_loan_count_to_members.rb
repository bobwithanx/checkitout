class AddLoanCountToMembers < ActiveRecord::Migration[5.1]
  def self.up
    add_column :members, :loans_count, :integer, null: false, default: 0
    add_column :members, :active_loans_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :members, :loans_count
    remove_column :members, :actives_loan_count
  end
end
