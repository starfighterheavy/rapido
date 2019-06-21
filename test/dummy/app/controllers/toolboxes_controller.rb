class ToolboxesController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController
  include Rapido::AppRecordNotFound

  before_action :authenticate_user!

  belongs_to :account, getter: :current_user_account
  attr_permitted :name
  lookup_param :name
end
