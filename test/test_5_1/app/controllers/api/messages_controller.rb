class Api::MessagesController < ActionController::API
  include Rapido::Controller
  include Rapido::ApiController

  belongs_to :comlink, foreign_key: :token
  free_from_authority!
  permit_all_params!
end
