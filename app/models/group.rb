class Group < ApplicationRecord
  has_many :members

  scope :active, -> { where(is_active: true) }
end
