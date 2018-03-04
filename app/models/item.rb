class Item < ApplicationRecord
  belongs_to :category, optional: true
  has_many :loans
  has_many :members, through: :loans

  def full_name
    "#{brand} #{name}"
  end
end
