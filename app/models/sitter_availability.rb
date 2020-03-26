class SitterAvailability < ApplicationRecord
  # add validation
  validate :time_range
  validate :no_overlapping_time_ranges, on: :create
  belongs_to :sitter

  def time_range
    min_hours = 2
    errors.add(:ends_at, :time_range, count: min_hours) if (attributes['ends_at'] - attributes['starts_at'])/3600 < min_hours
  end

  def no_overlapping_time_ranges
    new_sitter_range = starts_at..ends_at
    Sitter.find(sitter_id).sitter_availabilities.each do |sitter_availability|
      old_sitter_range = sitter_availability.starts_at..sitter_availability.ends_at
      if new_sitter_range.overlaps?(old_sitter_range)
        print('should throw times_overlapping error')
        errors.add(:ends_at, :times_overlapping)
      end
    end
  end
end
