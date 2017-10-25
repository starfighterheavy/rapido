class ToolboxesController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController

  before_action do
    resource_permitted_params
  end

  before_action :authenticate_user!

  owner_class :account

  resource_lookup_param :name
  resource_permitted_params [:name]

  def owner
    current_user.account
  end
end
