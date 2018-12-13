class Item < ApplicationRecord
  belongs_to :category
  has_many :loans
  has_one :active_loan, class_name: 'Loan'
  has_many :members, through: :loans

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  scope :unavailable, -> { joins(:loans).merge(Loan.active)}
  scope :available, -> { where.not(id: unavailable) }

  def on_loan?
    loans.active.present?
  end

  def full_name
    "#{brand} #{name}"
  end
end
