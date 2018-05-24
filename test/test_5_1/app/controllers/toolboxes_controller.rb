class ToolboxesController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController
  include Rapido::AppRecordNotFound

  authority :current_user_account

  before_action :authenticate_user!

  belongs_to_nothing!

  authority :current_user_account
  attr_permitted :name
  lookup_param :name
end
