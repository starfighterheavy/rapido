class Api::ToolboxesController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  owner_class :account
  resource_lookup_param :name
  resource_permitted_params [:name]

  private

  def owner
    @authority
  end
end
