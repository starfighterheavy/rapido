require 'virtual_widget'

class Api::VirtualWidgetsController < Api::ApplicationController
  include Rapido::Controller
  include Rapido::ApiController

  belongs_to :toolbox, foreign_key: :name, builder: :build_virtual_widget, finder: :find_virtual_widget
  lookup_param :name
  attr_permitted :name

  private

  def build_virtual_widget(params)
    VirtualWidget.new(toolbox, params)
  end

  def find_virtual_widget
    VirtualWidget.new(toolbox)
  end
end
