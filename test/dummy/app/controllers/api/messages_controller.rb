class Api::MessagesController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  attr_permitted :content

  skip_before_action :load_authority

  belongs_to :comlink, foreign_key: :token

  present_with Api::MessagePresenter

  present_collection_with Api::MessageCollectionPresenter, :query
end
