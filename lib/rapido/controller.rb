require 'active_support'
require 'active_support/core_ext'
require 'rapido/errors'

module Rapido
  module Controller
    extend ActiveSupport::Concern

    include Rapido::Errors

    included do
      define_method resource_class_name do
        resource
      end

      define_method resource_class_name.pluralize do
        resource_collection
      end

      if defined? helper_method
        helper_method resource_class_name
        helper_method resource_class_name.pluralize
      end
    end

    class_methods do
      def allow_only(*ary)
        @allowed_actions = ary
      end

      def attr_permitted(*ary)
        @resource_permitted_params = ary
      end

      def belongs_to(sym, opts = {})
        @owner_class = sym.to_sym
        define_method @owner_class do
          owner
        end
        if defined? helper_method
          helper_method @owner_class
        end
        @has_one = opts[:has_one]
        @owners_owner = opts[:owner]
        return @owner_getter = opts[:getter] if opts[:getter]
        return owner_lookup_defaults unless opts[:foreign_key]
        @owner_lookup_field = opts[:foreign_key]
        if opts[:foreign_key_param]
          owner_lookup_param(opts[:foreign_key_param])
        else
          owner_lookup_param(@owner_class, opts[:foreign_key])
        end
      end

      def collection_presented_by(presenter_class, *args)
        @collection_presenter ||= presenter_class
        @collection_presenter_args = args if args.count > 0
      end

      def owner_lookup_defaults
        owner_lookup_param(@owner_class, :id)
        owner_lookup_field(:id)
      end

      def owner_lookup_param(*args)
        return @owner_lookup_param = args[0].to_sym if args.count == 1
        @owner_lookup_param = args.join('_').to_sym
      end

      def owner_lookup_field(str)
        @owner_lookup_field = str.to_sym
      end

      def permit_no_params!
        @permit_no_params = true
      end

      def lookup_param(str)
        @resource_lookup_param = str.to_sym
      end

      def permit_all_params!
        @permit_all_params = true
      end

      def resource_class_from_controller
        self.name.split('::')[-1].remove('Controller').singularize.underscore
      end

      def resource_class_name
        resource_class_from_controller
      end

      def presented_by(presenter_class, *args)
        @presenter ||= presenter_class
        @presenter_args = args if args.count > 0
      end
    end

    private

      def allowed_actions
        setting(:allowed_actions)
      end

      def build_resource(params = {})
        return owner.send('build_' + resource_class_name, params) if setting(:has_one)
        return owner.send(resource_class_name.pluralize).build(params) if owner && owner.respond_to?(resource_class_name.pluralize)
        begin
          send(:build)
        rescue NoMethodError
          raise 'Rapido::Controller must belong to something that responds to build or define a build method'
        end
      end

      def collection_presenter
        setting(:collection_presenter)
      end

      def collection_presenter_args
        setting(:collection_presenter_args)
      end

      def owner_class
        return nil unless setting(:owner_class)
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
          if setting(:owner_getter)
            send(setting(:owner_getter))
          elsif setting(:owner_class)
            if setting(:owners_owner)
              base = send(setting(:owners_owner)).send(owner_class_name.pluralize)
            else
              base = owner_class
            end
            base.find_by!(owner_lookup_field => params[owner_lookup_param])
          else
            nil
          end
        rescue ActiveRecord::RecordNotFound
          raise RecordNotFound
        end
      end

      def presenter
        setting(:presenter)
      end

      def presenter_args
        setting(:presenter_args)
      end

      def resource
        @resource ||= begin
          if setting(:has_one)
            owner.send(resource_class_name)
          elsif owner && owner.respond_to?(resource_class_name.pluralize)
            owner
              .send(resource_class_name.pluralize)
              .find_by!(resource_lookup_param => params[resource_lookup_param])
          else
            begin NoMethodError
                  send(:find)
            rescue
              raise 'Rapido::Controller must belong to something that has many or has one of resource, or define a find method'
            end
          end
       rescue ActiveRecord::RecordNotFound
         raise RecordNotFound
        end
      end

      def resource_class
        @resource_class ||= resource_class_name.to_s.camelize.constantize
      end

      def resource_class_name
        self.class.resource_class_name
      end

      # Todo: FIXME
      def resource_collection
        @resource_collection ||= begin
          if setting(:has_one)
            owner.send(resource_class_name)
          else
            owner.send(resource_class_name.pluralize)
          end
        end
      end

      def resource_lookup_param
        @resource_lookup_param ||=
          setting(:resource_lookup_param) || :id
      end

      def resource_permitted_params
        @resource_permitted_params ||=
          setting(:resource_permitted_params)
      end

      def resource_params
        return {} if setting(:permit_no_params)
        base = params.require(resource_class_name)
        if setting(:permit_all_params)
          base.permit!
        else
          base.permit(resource_permitted_params)
        end
      end

      def setting(var)
        self.class.instance_variable_get("@#{var}")
      end
  end
end
