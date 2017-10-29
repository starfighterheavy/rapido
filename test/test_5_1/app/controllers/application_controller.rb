require 'rapido'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  include Rapido::Controller
  include Rapido::AppController
  include Rapido::AppRecordNotFound
end
