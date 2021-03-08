class Api::HydrospannersController < Api::ApplicationController
  include Rapido::ApiController

  allow_if :check_authority

  attr_permitted :name

  belongs_to :toolbox, foreign_key: :name

  lookup_param :name
end
