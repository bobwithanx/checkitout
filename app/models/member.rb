class Member < ApplicationRecord
  belongs_to :group, optional: true
  has_many :loans
  has_many :items, through: :loans
  has_paper_trail

  def full_name
    "#{first_name} #{last_name}"
  end

  ransack_alias :name_or_id_number, :first_name_or_last_name_or_id_number

  def self.search(search)
    where('id_number LIKE ? OR first_name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
