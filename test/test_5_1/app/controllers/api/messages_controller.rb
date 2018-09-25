class Api::MessagesController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  skip_before_action :load_authority

  belongs_to :comlink, foreign_key: :token

  permit_all_params!

  presented_by Api::MessagePresenter

  collection_presented_by Api::MessageCollectionPresenter, :query
end
