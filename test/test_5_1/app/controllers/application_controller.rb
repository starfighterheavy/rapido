require 'rapido'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  include Rapido::Controller
  include Rapido::AppController
  include Rapido::AppRecordNotFound

  authority :current_user_account

  private

  def current_user_account
    current_user.account
  end
end
