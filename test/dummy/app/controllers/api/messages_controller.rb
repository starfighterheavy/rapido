class Api::MessagesController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  attr_permitted :content

  skip_before_action :load_authority

  belongs_to :comlink, foreign_key: :token

  presented_by Api::MessagePresenter

  collection_presented_by Api::MessageCollectionPresenter, :query
end
