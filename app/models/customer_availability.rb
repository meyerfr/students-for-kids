class CustomerAvailability < ApplicationRecord
  validate :time_range
  belongs_to :customer

  def time_range
    min_hours = 2
    errors.add(:end, :time_range, count: min_hours) if (attributes['end'] - attributes['start'])/3600 < min_hours
  end
end
