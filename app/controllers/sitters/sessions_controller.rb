# frozen_string_literal: true

class Sitters::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  include Accessible
  skip_before_action :check_user, except: [:new]
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
