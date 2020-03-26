class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_sanitized_params, if: :devise_controller?

  def check_contact_info(resource)
    unless current_admin
      if resource.contact_info.attributes.except('customer_id', 'sitter_id').any?{|key, value| !value.present? }
        flash[:notice] = t(:update_profile_info)
        redirect_to public_send("edit_#{resource.class.to_s.downcase}_path", resource)
      end
    end
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def after_sign_in_path_for(resource)
    # check for the class of the object to determine what type it is
    if resource.class == Admin
      sitters_path
    elsif resource.class == Sitter
      resource.contact_info.phone.present? ? sitter_path(resource) : edit_sitter_path(resource)
    elsif resource.class == Customer
      resource.contact_info.phone.present? ? customer_path(resource) : edit_customer_path(resource)
    end
  end

  def configure_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :email,
      :password,:password_confirmation,
      contact_info_attributes: [
        :first_name,
        :last_name,
      ]
      ]
    )
  end

  def only_customers!
    unless current_admin || current_customer
      flash.alert = t :no_access, scope: [:activerecord, :flashes, :index], model: t(:sitter, scope: [:activerecord, :models])
      redirect_to bookings_path
    end
  end

  def authenticate_user!
    redirect_to root_path unless admin_signed_in? || sitter_signed_in? || customer_signed_in?
  end
end
