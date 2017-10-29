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

      def lookup_param(str)
        @resource_lookup_param = str.to_sym
      end

      def attr_permitted(*ary)
        @resource_permitted_params = ary.map(&:to_sym)
      end

      def free_from_authority!
        @free_from_authority = true
      end

      def permit_all_params!
        @permit_all_params = true
      end
    end

    private

      def resource_permitted_params
        @resource_permitted_params ||=
          setting(:resource_permitted_params)
      end

      def resource_params
        base = params.require(resource_class_name)
        if setting(:permit_all_params)
          base.permit!
        else
          base.permit(resource_permitted_params)
        end
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
          name = setting(:owner_class)
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
          setting(:owner_lookup_param).to_s
      end

      def owner_lookup_field
        @owner_lookup_field ||=
          (setting(:owner_lookup_field) || owner_lookup_param).to_s
      end

      def owner
        @owner ||= begin
          if setting(:free_from_authority)
            base = owner_class
          else
            base = authority.send(owner_class_name.pluralize)
          end
          base.find_by!(owner_lookup_field => params[owner_lookup_param])
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
          setting(:resource_lookup_param) || :id
      end

      def resource_class
        @resource_class ||=
          (setting(:resource_class) ||
          resource_class_from_controller).to_s.camelize.constantize
      end

      def resource_class_name(name = nil)
        @resource_class_name ||= resource_class.name.underscore
      end

      def resource_class_from_controller
        self.class.name.split('::')[-1].remove('Controller').singularize.underscore
      end

      def setting(var)
        self.class.instance_variable_get("@#{var}")
      end
  end
end
