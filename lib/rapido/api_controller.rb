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
      render json: present_resource_collection(resource_collection)
    end

    def show
      render json: present_resource(resource)
    end

    def create
      new_resource = build_resource(resource_params)
      if new_resource.save
        render json: present_resource(new_resource), status: :created
      else
        render json: { errors: new_resource.errors.full_messages }, status: 422
      end
    end

    def destroy
      resource_before_destruction = present_resource(resource)
      resource.destroy
      render json: resource_before_destruction
    end

    def update
      resource.assign_attributes(resource_params)
      if resource.save
        render json: present_resource(resource)
      else
        render json: { errors: resource.errors.full_messages }, status: 422
      end
    end

    private

    def present_resource(resource)
      args = presenter_args.nil? ? nil : presenter_args.map { |arg| params[arg] }
      return presenter.new(*[resource, *args]).as_json if presenter
      resource.to_h
    end

    def present_resource_collection(resource_collection)
      args = collection_presenter_args.nil? ? nil : collection_presenter_args.map { |arg| params[arg] }
      return collection_presenter.new(*[resource_collection, *args]).as_json if collection_presenter
      return resource_collection.map{ |r| presenter.new(r).as_json } if presenter
      resource_collection.map(&:to_h)
    end
  end
end
