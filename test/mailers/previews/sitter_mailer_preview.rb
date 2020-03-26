# Preview all emails at http://localhost:3000/rails/mailers/sitter_mailer
class SitterMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/sitter_mailer/welcome
  def welcome
    SitterMailer.welcome(Sitter.first)
  end

end
