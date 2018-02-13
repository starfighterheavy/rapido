require 'active_support'
require 'active_support/core_ext'
require 'active_support/rescuable'
require 'rapido/errors'

module Rapido
  module ApiController
    extend ActiveSupport::Concern

    include Rapido::Errors

    included do
      rescue_from RecordNotFound do |e|
        render json: { errors: [ e.to_s ] }, status: 404
      end
    end

    def index
      render json: resource_collection.map(&:to_h)
    end

    def show
      render json: resource.to_h
    end

    def create
      new_resource = build_resource(resource_params)
      if new_resource.save
        render json: new_resource.to_h, status: :created
      else
        render json: { errors: new_resource.errors.full_messages }, status: 422
      end
    end

    def destroy
      resource_hsh = resource.to_h
      resource.destroy
      render json: resource_hsh
    end

    def update
      resource.assign_attributes(resource_params)
      if resource.save
        render json: resource.to_h
      else
        render json: { errors: resource.errors.full_messages }, status: 422
      end
    end
  end
end
