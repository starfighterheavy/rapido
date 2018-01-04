class HydrospannersController < ApplicationController
  include Rapido::AppViews

  belongs_to :toolbox, foreign_key: :name
  attr_permitted :name
  lookup_param :name

  private

  def after_create_success(hydrospanner)
    render plain: "Rendered text: " + hydrospanner.name
  end

  def after_create_failure(*)
    render plain: "Rendered text: " + flash[:error]
  end
end
