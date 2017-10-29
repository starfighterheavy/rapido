class Api::ToolboxesController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  owner_class :account
  lookup_param :name
  attr_permitted :name

  private

  def owner
    @authority
  end
end
