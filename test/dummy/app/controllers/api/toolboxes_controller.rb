class Api::ToolboxesController < Api::ApplicationController
  include Rapido::ApiController

  allow_if do
    authority.present?
  end

  attr_permitted :name

  belongs_to :account, getter: :authority

  lookup_param :name
end
