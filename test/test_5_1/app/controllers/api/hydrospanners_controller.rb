class Api::HydrospannersController < Api::ApplicationController
  include Rapido::Controller

  resource_owner_name :account
  resource_param_name :name

  def resource_create_permitted_params
    [:name]
  end

  def resource_update_permitted_params
    [:name]
  end

  def resource_class
    Hydrospanner
  end

  def resource_owner
    @resource_owner ||= Account.find_by!(api_key: params[:api_key])
  end
end
