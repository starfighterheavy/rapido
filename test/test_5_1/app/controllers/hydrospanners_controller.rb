class HydrospannersController < ApplicationController
  include Rapido::AppViews

  belongs_to :toolbox, foreign_key: :name
  attr_permitted :name
  lookup_param :name
end
