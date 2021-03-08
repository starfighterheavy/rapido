require 'virtual_widget'

class Api::VirtualWidgetsController < Api::ApplicationController
  include Rapido::ApiController

  belongs_to :toolbox, foreign_key: :name

  attr_permitted :name

  allow_if :check_authority

  private

  def build
    VirtualWidget.new(toolbox, params)
  end

  def find
    VirtualWidget.new(toolbox)
  end
end
