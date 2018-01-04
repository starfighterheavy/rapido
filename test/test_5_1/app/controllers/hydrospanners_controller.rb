class HydrospannersController < ApplicationController
  include Rapido::AppViews

  belongs_to :toolbox, foreign_key: :name
  attr_permitted :name
  lookup_param :name

  private

  def after_create_success(*)
    flash[:success] = flash[:success].to_s + "Well done!"
  end
end
