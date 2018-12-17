class Member < ApplicationRecord
  belongs_to :group
  has_many :loans
  has_many :active_loans, ->{ active }, class_name: 'Loan'
  has_many :completed_loans, ->{ completed }, class_name: 'Loan'
  has_many :items, through: :loans
  has_paper_trail

  def full_name
    "#{first_name} #{last_name}"
  end

  def title
    self.full_name
  end

  def is_active?
    self.group.is_active
  end

  scope :active, -> {
    joins(:group)
      .merge(Group.active)
  }

  scope :with_loans, -> {
    where("active_loans_count > ?", 0)
  }

  default_scope { order(last_name: :asc, first_name: :asc) }
end
