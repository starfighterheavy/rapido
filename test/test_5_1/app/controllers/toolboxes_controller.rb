class ToolboxesController < ApplicationController
  before_action :authenticate_user!

  owner_class :account

  resource_lookup_param :name
  resource_permitted_params [:name]

  def owner
    current_user.account
  end
end
