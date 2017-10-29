class Api::ToolboxesController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  belongs_to :account, getter: :authority
  lookup_param :name
  attr_permitted :name
end
