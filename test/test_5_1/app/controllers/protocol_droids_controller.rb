class User::ProtocolDroidsController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController

  before_action :authenticate_user!

  belongs_to :user, getter: :current_user, has_one: true

  attr_permitted :name
  lookup_param :name

  private

  def after_create_path(protocol_droid)
    user_protocol_droid_path(protocol_droid)
  end

  def after_update_success(protocol_droid)
    render plain: "Success! You've updated #{protocol_droid.name}"
  end

  def after_update_failure(protocol_droid)
    render plain: "Blast it! You've failed to update #{protocol_droid.name}"
  end

  def after_destroy_success(protocol_droid)
    render plain: "Success! You've destroyed #{protocol_droid.name}"
  end
end
