# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/sitter_found
  def sitter_found
    BookingMailer.sitter_found(Booking.first)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/customer_found
  def customer_found
    BookingMailer.customer_found(Booking.first)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/sitter_thanks
  def sitter_thanks
    BookingMailer.sitter_thanks(Booking.first)
  end
end
