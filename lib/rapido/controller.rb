require 'active_support'
require 'active_support/core_ext'
require 'active_support/rescuable'

module Rapido
  module Controller
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound do |e|
        render json: { errors: [ e.to_s ] }, status: 404
      end
    end

    class_methods do
      def resource_owner_name(name = nil)
        @resource_owner_name = name.to_s if name
        @resource_owner_name
      end
    end

    def index
      render json: { resource_name.pluralize => resource_collection.map(&:to_h), meta: index_meta }
    end

    def show
      render json: resource.to_h
    end

    def create
      new_resource = build_resource
      if new_resource.save
        render json: new_resource.to_h
      else
        render json: { errors: new_resource.errors.full_messages }, status: 422
      end
    end

    def destroy
      resource.destroy
      head :ok
    end

    def update
      resource.assign_attributes(resource_update_params)
      if resource.save
        render json: resource.to_h
      else
        render json: { errors: resource.errors.full_messages }, status: 422
      end
    end

    private

      def index_meta
        {
          pagination: {
            per_page: resource_collection.limit_value,
            total_pages: resource_collection.total_pages,
            total_objects: resource_collection.count,
          }
        }
      end

      def resource_required_param
        resource_name.to_sym
      end

      def resource_create_permitted_params
        []
      end

      def resource_update_permitted_params
        []
      end

      def resource_update_params
        params
          .require(resource_required_param)
          .permit(resource_update_permitted_params)
      end

      def resource_create_params
        params
          .require(resource_required_param)
          .permit(resource_create_permitted_params)
      end

      def build_resource_params
        {
          resource_owner_reference.to_sym => resource_owner.id
        }.merge(resource_create_params)
      end

      def build_resource
        resource_class.new(build_resource_params)
      end

      def resource_collection
        resource_class
          .where("#{resource_owner_reference} = ?", resource_owner.id)
          .page(params[:page])
      end

      def resource_owner_name
        return self.class.resource_owner_name if self.class.resource_owner_name
        @resource_owner_name ||= resource_owner.class.name.underscore
      end

      def resource_owner_class
        @resource_owner_class ||= resource_owner_name.camelize.constantize
      end

      def resource_owner_reference
        "#{resource_owner_name}_id"
      end

      def resource_owner
        @resource_owner ||= resource_owner_class.find(params[resource_owner_reference])
      end

      def resource
        @resource ||=
          resource_class
            .where("#{resource_owner_reference} = ?", resource_owner.id)
            .find(params[:id])
      end

      def resource_reference
        "#{resource_name}_id"
      end

      def resource_class
        @resource_class ||=
          resource_controller_class.constantize
      end

      def resource_name(name = nil)
        return @resource_name = name if name
        @resource_name ||= resource_controller_class.underscore
      end

      def resource_controller_class
        @resource_controller_class ||=
          self.class.name.split('::')[-1].remove('Controller').singularize
      end

      class ResourceOwnerNameNotSpecified < StandardError; end
  end
end
