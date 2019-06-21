require 'active_support'
require 'active_support/core_ext'
require 'rapido/errors'

module Rapido
  module AppController
    extend ActiveSupport::Concern
    include Rapido::Errors

    included do
      Rails.logger.info 'The AppController has been deprecated and will be removed in the v1.0 release.'
      before_action do
        resource_permitted_params
      end
      helper_method :owned_resources
    end

    def index
      @resource_collection = resource_collection
    end

    def show
      @resource = resource
    end

    def new
      @resource = build_resource
    end

    def create
      new_resource = build_resource(resource_params)
      if new_resource.save
        after_create_success(new_resource)
        return if performed?
        redirect_to after_create_path(new_resource)
      else
        flash[:error] = new_resource.errors.full_messages.join('. ')
        after_create_failure(new_resource)
        return if performed?
        redirect_to new_path
      end
    end

    def destroy
      unless resource.destroy
        flash[:error] = resource.errors.full_messages.join('. ')
      end
      after_destroy_success(resource)
      return if performed?
      redirect_to after_delete_path(resource)
    end

    def edit
      @resource = resource
    end

    def update
      resource.assign_attributes(resource_params)
      if resource.save
        after_update_success(resource)
        return if performed?
        redirect_to after_update_path(resource)
      else
        flash[:error] = resource.errors.full_messages.join('. ')
        resource.reload
        after_update_failure(resource)
        return if performed?
        redirect_to edit_path(resource)
      end
    end

    private

      def after_create_success(*)
      end

      def after_create_failure(*)
      end

      def after_update_success(*)
      end

      def after_update_failure(*)
      end

      def after_destroy_success(*)
      end

      def resource_path(action, resource = nil)
        keys = { controller: params[:controller], action: action }
        keys[resource_lookup_param] = resource.send(resource_lookup_param) if resource
        keys[owner_lookup_param] = owner.send(owner_lookup_field) if owner_lookup_param.present?
        url_for(keys)
      end

      def edit_path(resource)
        @edit_path ||= resource_path(:edit, resource)
      end

      def show_path(resource)
        @show_path ||= resource_path(:show, resource)
      end

      def new_path
        @new_path ||= resource_path(:new)
      end

      def index_path
        @index_path ||= resource_path(:index)
      end

      def after_create_path(resource)
        show_path(resource)
      end

      def after_update_path(resource)
        show_path(resource)
      end

      def after_delete_path(*)
        index_path
      end
  end
end
