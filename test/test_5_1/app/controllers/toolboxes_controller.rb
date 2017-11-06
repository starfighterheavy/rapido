class ToolboxesController < ApplicationController
  include Rapido::AppViews
  before_action :authenticate_user!

  belongs_to_nothing!
  has_many :hydrospanners

  authority :current_user_account
  attr_permitted :name
  lookup_param :name
end
