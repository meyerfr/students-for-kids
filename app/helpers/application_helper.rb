module ApplicationHelper
  def current_user?
    admin_signed_in? || customer_signed_in? || sitter_signed_in?
  end

  def current_user
    current_admin || current_customer || current_sitter
  end

  def correct_sign_out_path
    case current_user.class
    when Admin
      :destroy_admin_session_path
    when Customer
      :destroy_customer_session_path
    when
      :destroy_sitter_session_path
    end
  end
end
