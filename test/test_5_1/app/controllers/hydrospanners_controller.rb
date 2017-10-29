class HydrospannersController < ApplicationController
  include Rapido::AppViews

  attr_permitted :name
  lookup_param :name

  owner_class :toolbox
  owner_lookup_param :toolbox_name
  owner_lookup_field :name

  private

  def authority
    current_user.account
  end
end
