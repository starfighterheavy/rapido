require 'active_support'
require 'active_support/core_ext'
require 'active_support/rescuable'
require 'rapido/errors'

module Rapido
  module Controller
    extend ActiveSupport::Concern

    include Rapido::Errors

    class_methods do
      def owner_class(str)
        @owner_class = str.to_sym
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
        @resource_collection ||= begin
          raise RecordNotFound unless owner
          owner.send(resource_class_name.pluralize).page(params[:page])
        end
      end

      def owner_class
        @owner_class ||= begin
          name = self.class.instance_variable_get(:@owner_class)
          name.to_s.camelize.constantize
        rescue NameError
          raise BadOwnerClassName, name
        end
      end

      def owner_class_name
        @owner_class_name ||= owner_class.name.downcase
      end

      def owner_lookup_param
        @owner_lookup_param ||=
          self.class.instance_variable_get(:@owner_lookup_param).to_s
      end

      def owner_lookup_field
        @owner_lookup_field ||=
          (self.class.instance_variable_get(:@owner_lookup_field) || owner_lookup_param).to_s
      end

      def owner
        @owner ||= begin
           authority.send(owner_class_name.pluralize)
                    .find_by(owner_lookup_field => params[owner_lookup_param])
         rescue ActiveRecord::RecordNotFound
           raise RecordNotFound
         end
      end

      def resource
        @resource ||= begin
          owner
            .send(resource_class_name.pluralize)
            .find_by!(resource_lookup_param => params[resource_lookup_param])
        rescue ActiveRecord::RecordNotFound
          raise RecordNotFound
        end
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
  end
end
