class Api::HydrospannersController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  owner_class :toolbox
  owner_lookup_param :toolbox_name
  owner_lookup_field :name
  lookup_param :name
  attr_permitted :name
end
