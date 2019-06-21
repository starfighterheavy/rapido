require 'virtual_widget'

class Api::VirtualWidgetsController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  belongs_to :toolbox, foreign_key: :name
  attr_permitted :name

  private

    def build
      VirtualWidget.new(toolbox, params)
    end

    def find
      VirtualWidget.new(toolbox)
    end
end
