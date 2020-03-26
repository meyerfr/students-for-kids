class SitterMailer < ApplicationMailer
  before_action :set_attachments
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sitter_mailer.welcome.subject
  #
  def welcome(sitter)
    @contact_info = sitter.contact_info

    email_with_name = %("#{@contact_info.full_name}" <#{sitter.email}>)
    mail(to: email_with_name, subject: 'Willkommen bei Students for Kids')
  end

  def set_attachments
    attachments.inline['hand-print-green.png'] = File.read("#{Rails.root}/app/assets/images/hand-print-green.png")
    attachments.inline['hygiene-info.jpeg'] = File.read("#{Rails.root}/app/assets/images/hygiene-info.jpeg")
  end
end
