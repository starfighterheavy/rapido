class User::ProtocolDroidsController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController
  include Rapido::AppViews

  before_action :authenticate_user!

  belongs_to :user, getter: :current_user, has_one: true

  attr_permitted :name
  lookup_param :name

  private

  def after_create_path(protocol_droid)
    user_protocol_droid_path(protocol_droid)
  end
end
