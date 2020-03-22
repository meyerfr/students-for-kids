class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def after_sign_in_path_for(resource)
    # check for the class of the object to determine what type it is
    if resource.class == Admin
      edit_admin_path(resource)
    elsif resource.class == Sitter
      resource.contact_info.present? ? sitter_path(resource) : edit_sitter_path(resource)
    elsif resource.class == Customer
      resource.contact_info.present? ? customer_path(resource) : edit_customer_path(resource)
    end
  end
end
