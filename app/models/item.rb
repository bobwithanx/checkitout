class Item < ApplicationRecord
  belongs_to :category, optional: true
  has_many :loans
  has_many :members, through: :loans

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


  def full_name
    "#{brand} #{name}"
  end
end
