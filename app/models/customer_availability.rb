class CustomerAvailability < ApplicationRecord
  validate :check_time, :no_overlapping_time_ranges
  belongs_to :customer

  def check_time
    min_hours = 2
    errors.add(:ends_at, :time_range, count: min_hours) if (self.ends_at - self.starts_at)/3600 < min_hours
    errors.add(:ends_at, :time_is_in_the_past) if self.starts_at.to_date < Date.today
  end

  def no_overlapping_time_ranges
    new_customer_range = starts_at..ends_at
    Customer.find(customer_id).customer_availabilities.where.not(id: self.id).each do |customer_availability|
      old_customer_range = customer_availability.starts_at..customer_availability.ends_at
      if new_customer_range.overlaps?(old_customer_range)
        errors.add(:ends_at, :times_overlapping)
      end
    end
  end
end
