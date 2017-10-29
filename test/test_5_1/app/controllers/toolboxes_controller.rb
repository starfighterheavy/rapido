class ToolboxesController < ApplicationController
  before_action :authenticate_user!

  attr_permitted :name
  lookup_param :name

  owner_class :account


  def owner
    current_user.account
  end
end
