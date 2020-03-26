class Booking < ApplicationRecord
  after_create :send_booking_emails
  belongs_to :customer
  belongs_to :sitter

  private

  def send_booking_emails
    BookingMailer.customer_found(self).deliver_now
    BookingMailer.sitter_found(self).deliver_now
    BookingMailer.sitter_thanks(self).deliver_later(wait_until: self.ends_at+4.hours)
  end
end
