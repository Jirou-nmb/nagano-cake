class Customers::ApplicationController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def after_sign_in_path_for(resource)
  #   customer_path(current_customer.id)
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :name,
      # :postcode,
      # :prefecture_name,
      # :address_city,
      # :address_street
      ])
  end
end