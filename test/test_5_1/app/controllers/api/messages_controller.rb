class Api::MessagesController < ActionController::API
  include Rapido::Controller
  include Rapido::ApiController

  owner_class :comlink
  owner_lookup_param :comlink_token
  owner_lookup_field :token

  free_from_authority!
  permit_all_params!
end
