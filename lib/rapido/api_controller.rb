require 'active_support'
require 'active_support/core_ext'
require 'active_support/rescuable'
require 'rapido/controller'
require 'rapido/errors'

module Rapido
  module ApiController
    extend ActiveSupport::Concern

    include Rapido::Errors

    included do
      include Rapido::Controller

      rescue_from RecordNotFound do |e|
        render json: { errors: [ e.to_s ] }, status: 404
      end

      before_action :permit_only_allowed_actions
    end

    def index
      return if performed?
      render json: present_resource_collection(resource_collection)
    end

    def show
      return if performed?
      render json: present_resource(resource)
    end

    def create
      return if performed?
      render json: present_resource(resource)
      before_build
      new_resource = build_resource(resource_params)
      before_create(new_resource)
      if new_resource.save
        after_create_success(new_resource)
        return if performed?
        render json: present_resource(new_resource), status: :created
      else
        after_create_failure(new_resource)
        return if performed?
        render json: { errors: new_resource.errors.full_messages }, status: 422
      end
    end

    def destroy
      return if performed?
      resource_before_destruction = present_resource(resource)
      before_destroy
      resource.destroy
      after_destroy_success
      return if performed?
      render json: resource_before_destruction
    end

    def update
      return if performed?
      before_assign_attributes
      resource.assign_attributes(resource_params)
      before_update
      if resource.save
        after_update_success
        return if performed?
        render json: present_resource(resource)
      else
        after_update_failure
        return if performed?
        render json: { errors: resource.errors.full_messages }, status: 422
      end
    end

    private

    def after_create_failure(new_resource)
    end

    def after_create_success(new_resource)
    end

    def after_destroy_success
    end

    def after_update_failure
    end

    def after_update_success
    end

    def before_assign_attributes
    end

    def before_build
    end

    def before_create(new_resource)
    end

    def before_destroy
    end

    def before_update
    end

    def permit_only_allowed_actions
      return unless allowed_actions
      head :unauthorized unless allowed_actions.include?(params[:action].to_sym)
    end

    def present_resource(resource)
      args = presenter_args.nil? ? nil : presenter_args.map { |arg| params[arg] }
      return presenter.new(resource, *args).as_json if presenter
      resource.to_h
    end

    def present_resource_collection(resource_collection)
      args = collection_presenter_args.nil? ? nil : collection_presenter_args.map { |arg| params[arg] }
      return collection_presenter.new(resource_collection, *args).as_json if collection_presenter
      return resource_collection.map { |r| presenter.new(r).as_json } if presenter
      resource_collection.map(&:to_h)
    end
  end
end
