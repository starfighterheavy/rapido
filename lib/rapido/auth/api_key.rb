module Rapido
  module Auth
    module ApiKey
      extend ActiveSupport::Concern

      included do
        before_action :load_authority

        rescue_from LackAuthority do |e|
          render json: { error: 'Request denied.' }, status: 401
        end
      end

      def authority_class
        @authority_class ||=
          Rapido.configuration.authority_class.to_s.camelize.constantize
      end

      def authority_lookup_param
        @authority_lookup_param ||=
          Rapido.configuration.authority_lookup_param
      end

      def authority_lookup_field
        @authority_lookup_field ||=
          Rapido.configuration.authority_lookup_field
      end

      def load_authority
        @authority = authority_class.find_by(authority_lookup_field => params[authority_lookup_param])
        raise LackAuthority unless @authority
      end

      class LackAuthority < StandardError; end
    end
  end
end
