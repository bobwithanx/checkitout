class Loan < ApplicationRecord
  belongs_to :member
  counter_culture :member, column_name: proc { |model| model.active? ? 'active_loans_count' : nil }
  counter_culture :member
  has_paper_trail

  belongs_to :item

  enum status: %i[active complete]

  after_save :update_status, if: :saved_change_to_returned_at?

  default_scope { order(created_at: :desc) }

  validates_uniqueness_of :item, conditions: -> { where(status: 'active') }

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
    complete!
  end
end
