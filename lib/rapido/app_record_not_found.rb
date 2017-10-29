module Rapido
  module AppRecordNotFound
    extend ActiveSupport::Concern
    include Rapido::Errors

    included do
      rescue_from RecordNotFound do |e|
        render file: 'public/404', status: :not_found, layout: false
      end
    end
  end
end
