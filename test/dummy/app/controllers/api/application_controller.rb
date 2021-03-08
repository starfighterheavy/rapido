require 'rapido'
class Api::ApplicationController < ActionController::API
  before_action :load_authority

  class LackAuthority < StandardError; end

  rescue_from LackAuthority do |_e|
    render json: { error: 'Request denied.' }, status: 401
  end

  def load_authority
    @authority = Account.find_by(api_key: params[:api_key])
  end

  def authority
    @authority
  end

  def check_authority
    authority.present?
  end
end
