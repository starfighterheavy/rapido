require 'active_support'
require 'active_support/core_ext'
require 'active_support/rescuable'

module Rapido
  module Controller
    extend ActiveSupport::Concern

    class_methods do
      def owner_class(str)
        @owner_class = str.to_sym
      end

      def owner_foreign_key(key)
        @owner_foreign_key = key.to_sym
      end

      def owner_lookup_param(str)
        @owner_lookup_param = str.to_sym
      end

      def owner_lookup_field(str)
        @owner_lookup_field = str.to_sym
      end

      def resource_class(str)
        @resource_class = str.to_sym
      end

      def resource_lookup_param(str)
        @resource_lookup_param = str.to_sym
      end

      def resource_permitted_params(ary)
        @resource_permitted_params = ary.map(&:to_sym)
      end
    end

    included do
      rescue_from ActiveRecord::RecordNotFound do |e|
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
      new_resource = build_resource
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

    private

      def resource_permitted_params
        @resource_permitted_params ||=
          self.class.instance_variable_get(:@resource_permitted_params)
      end

      def resource_params
        params.require(resource_class_name).permit(resource_permitted_params)
      end

      def build_resource
        owner.send(resource_class_name.pluralize).new(resource_params)
      end

      def resource_collection
        resource_class
          .where("#{owner_foreign_key} = ?", owner.id)
          .page(params[:page])
      end

      def owner_class
        @owner_class ||=
          self.class.instance_variable_get(:@owner_class).to_s.camelize.constantize
      end

      def owner_class_name
        @owner_class_name ||= owner_class.name
      end

      def owner_foreign_key
        @owner_foreign_key ||=
          (self.class.instance_variable_get(:@owner_foreign_key) ||
          "#{owner_class_name}_id").to_s
      end

      def owner_lookup_param
        @owner_lookup_param ||=
          (self.class.instance_variable_get(:@owner_lookup_param) || owner_foreign_key).to_s
      end

      def owner_lookup_field
        @owner_lookup_field ||=
          (self.class.instance_variable_get(:@owner_lookup_field) || owner_lookup_param).to_s
      end

      def owner
        @owner ||= owner_class.find_by(owner_lookup_field => params[owner_lookup_param])
      end

      def resource
        @resource ||=
          resource_class
            .where("#{owner_foreign_key} = ?", owner.id)
            .find_by(resource_lookup_param => params[resource_lookup_param])
      end

      def resource_lookup_param
        @resource_lookup_param ||=
          self.class.instance_variable_get(:@resource_lookup_param) || :id
      end

      def resource_class
        @resource_class ||=
          (self.class.instance_variable_get(:@resource_class) ||
          resource_class_from_controller).to_s.camelize.constantize
      end

      def resource_class_name(name = nil)
        @resource_class_name ||= resource_class.name.underscore
      end

      def resource_class_from_controller
        self.class.name.split('::')[-1].remove('Controller').singularize.underscore
      end

      class ResourceOwnerNameNotSpecified < StandardError; end
  end
end
