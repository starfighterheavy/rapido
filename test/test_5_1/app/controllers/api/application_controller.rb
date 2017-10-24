require_relative '../../../../../lib/rapido/controller'

class Api::ApplicationController < ApplicationController
  before_action :load_account

  def load_account
    @account = Account.find_by(api_key: params[:api_key])
    return @account if @account
    raise InvalidApiKey
  end

  class InvalidApiKey < StandardError; end

  rescue_from InvalidApiKey do |e|
    render json: { error: "Invalid api_key." }, status: 401
  end
end

