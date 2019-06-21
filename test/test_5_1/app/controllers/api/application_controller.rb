require 'rapido'
class Api::ApplicationController < ActionController::API
  include Rapido::Auth::ApiKey
end
