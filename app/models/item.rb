class Item < ApplicationRecord
  belongs_to :category, optional: true
  has_many :loans
  has_one :active_loan, ->{ active }, class_name: 'Loan'
  has_many :members, through: :loans

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  scope :unavailable, -> { joins(:loans).merge(Loan.active)}
  scope :available, -> { where.not(id: unavailable) }

  ransack_alias :name_or_tag, :brand_or_name_or_description_or_inventory_tag

  def full_name
    "#{brand} #{name}"
  end

  def self.search(search)
    where('brand LIKE ? OR name LIKE ? OR description LIKE ? OR inventory_tag LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
