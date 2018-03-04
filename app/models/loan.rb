class Loan < ApplicationRecord
  belongs_to :member
  belongs_to :item

  enum status: %i[active returned]

  after_save :update_status, if: :saved_change_to_returned_at?

  default_scope { order(created_at: :desc) }

  # named_scope :recent, order: ['created_at DESC'], limit: 5

  def short_date
    if returned_at.nil?
      created_at.strftime('%F')
    else
      returned_at.strftime('%F')
    end
  end

  def days_borrowed
    days = (returned_at.to_date - created_at.to_date).to_i
    if days.zero?
      'same day'
    elsif days == 1
      'overnight'
    else
      days 'days'
    end
  end

  def complete?
    returned?
  end

  def update_status
    returned!
  end
end
