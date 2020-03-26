class CustomerAvailability < ApplicationRecord
  validate :check_time, :no_overlapping_time_ranges
  belongs_to :customer

  def check_time
    min_hours = 2
    errors.add(:ends_at, :time_range, count: min_hours) if (attributes['ends_at'] - attributes['starts_at'])/3600 < min_hours
    errors.add(:ends_at, :time_is_in_the_past) if (attributes['starts_at'].to_date < Date.today)
  end

  def no_overlapping_time_ranges
    new_sitter_range = starts_at..ends_at
    Sitter.each do |sitter|
      old_sitter_range = sitter.starts_at..sitter.ends_at
      if new_sitter_range.overlaps?(old_sitter_range)
        errors.add[:ends_at, :times_overlapping]
      end
    end
  end
end
