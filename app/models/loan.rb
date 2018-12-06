class Loan < ApplicationRecord
  belongs_to :member
  belongs_to :item
  has_one :category, through: :item
  counter_culture :member, column_name: 'active_loans_count'
  has_paper_trail

  enum status: %i[on_loan returned]
  after_save :update_status, if: :saved_change_to_returned_at?

  scope :active, -> {
    where(status: 0)
  }
  scope :completed, -> {
    where(status: 1)
  }
  default_scope { order(returned_at: :desc, created_at: :desc) }

  def title
    self.item.name + " (" + self.created_at.strftime("%Y-%m-%d") + ")"
  end

  def today?
    created_at.to_date == Time.zone.now.beginning_of_day.to_date
  end

  def days_borrowed
    return '-' unless returned_at
    days = (returned_at.to_date - created_at.to_date).to_i
    if days.zero?
      'same day'
    elsif days == 1
      'overnight'
    else
      days.to_s + ' days'
    end
  end

  def update_status
    returned!
  end
end
