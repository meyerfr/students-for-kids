module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_admin
      flash.clear
      flash[:notice] = 'Du bist bereits als Admin angemeldet'
      # if you have rails_admin. You can redirect anywhere really
      redirect_to(rails_admin.dashboard_path) and return
    elsif current_sitter
      flash.clear
      flash[:notice] = 'Du bist bereits als Babysitter angemeldet'
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(sitter_path(current_sitter)) and return
    elsif current_customer
      flash.clear
      flash[:notice] = 'Du bist bereits als Kunde angemeldet'
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(bookings_path) and return
    end
  end
end
