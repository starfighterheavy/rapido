class HydrospannersController < ApplicationController
  include Rapido::AppViews

  belongs_to :toolbox, foreign_key: :name
  attr_permitted :name
  lookup_param :name
  authority :current_user_account

  private

  def current_user_account
    current_user.account
  end
end
