module Rapido
  module AppViews
    extend ActiveSupport::Concern

    included do
      before_action do
        append_view_path (Rapido::Engine.root + 'app/views/rapido')
      end
    end

    class_methods do
      def local_prefixes
        [controller_path, 'app']
      end
    end
  end
end

