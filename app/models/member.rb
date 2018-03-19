class Member < ApplicationRecord
  belongs_to :group, optional: true
  has_many :loans
  has_many :items, through: :loans

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search(search)
    where('id_number LIKE ? OR first_name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
