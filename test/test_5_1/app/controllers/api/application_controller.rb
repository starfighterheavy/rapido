require_relative '../../../../../lib/rapido/controller'

class Api::ApplicationController < ApplicationController
  include Rapido::Auth::ApiKey
end

