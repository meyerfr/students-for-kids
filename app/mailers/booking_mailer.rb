class BookingMailer < ApplicationMailer
  before_action :set_attachments
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.sitter_found.subject
  #
  def sitter_found(booking)
    @booking = booking
    @contact_info_customer = @booking.customer.contact_info
    @contact_info_sitter = @booking.sitter.contact_info

    email_with_name = %("#{@contact_info_customer.full_name}" <#{@booking.customer.email}>)
    mail(to: email_with_name, subject: 'Perfekten Babysitter gefunden | Students for Kids')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.customer_found.subject
  #
  def customer_found(booking)
    @booking = booking
    @customer = @booking.customer
    @contact_info_customer = @customer.contact_info
    @contact_info_sitter = @booking.sitter.contact_info

    email_with_name = %("#{@contact_info_sitter.full_name}" <#{@booking.sitter.email}>)
    mail(to: email_with_name, subject: 'Kunde gefunden | Students for Kids')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.sitter_thanks.subject
  #
  def sitter_thanks(booking)
    @booking = booking
    @contact_info_customer = @booking.customer.contact_info
    @contact_info_sitter = @booking.sitter.contact_info

    email_with_name = %("#{@contact_info_sitter.full_name}" <#{@booking.sitter.email}>)
    mail(to: email_with_name, subject: 'Danke für deinen Einsatz | Students for Kids')
  end

  def set_attachments
    attachments.inline['hand-print-green.png'] = File.read("#{Rails.root}/app/assets/images/hand-print-green.png")
    attachments.inline['hygiene-info.jpeg'] = File.read("#{Rails.root}/app/assets/images/hygiene-info.jpeg")
  end
end
