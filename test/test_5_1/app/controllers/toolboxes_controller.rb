class ToolboxesController < ApplicationController
  before_action :authenticate_user!

  belongs_to :account, getter: :current_user_account
  attr_permitted :name
  lookup_param :name

  private

  def current_user_account
    current_user.account
  end
end
