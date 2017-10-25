class Api::HydrospannersController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  owner_class :toolbox
  owner_lookup_param :toolbox_name
  owner_lookup_field :name
  resource_lookup_param :name
  resource_permitted_params [:name]
end
