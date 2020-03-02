require 'empty_widget'

class Api::EmptyWidgetsController < Api::ApplicationController
  include Rapido::ApiController

  belongs_to :toolbox, foreign_key: :name, has_one: true
  lookup_param :name
  permit_no_params!
end
