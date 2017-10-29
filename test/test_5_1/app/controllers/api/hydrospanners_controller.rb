class Api::HydrospannersController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  belongs_to :toolbox, foreign_key: :name
  lookup_param :name
  attr_permitted :name
end
