module Rapido
  module Errors
    class BadOwnerClassName < StandardError; end
    class ResourceOwnerNameNotSpecified < StandardError; end
    class RecordNotFound < StandardError; end
    class AuthorityIsNotDefined < StandardError; end
  end
end
