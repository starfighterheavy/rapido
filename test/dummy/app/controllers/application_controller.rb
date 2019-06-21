require 'rapido'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

    def current_user_account
      current_user.account
    end
end
