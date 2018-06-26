class HydrospannersController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController
  include Rapido::AppRecordNotFound

  belongs_to :toolbox, foreign_key: :name, owner: :current_user_account
  attr_permitted :name
  lookup_param :name

  private

  def after_create_success(hydrospanner)
    render plain: "Rendered text: " + hydrospanner.name
  end

  def after_create_failure(*)
    render plain: "Rendered text: " + flash[:error]
  end
end
