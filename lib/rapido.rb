require 'rapido/version'
require 'rapido/controller'
require 'rapido/auth/api_key'

module Rapido
  class << self
    attr_writer :configuration
  end

  class Configuration
    attr_accessor :authority_class, :authority_lookup_param, :authority_lookup_field

    def initialize
      @authority_class = :account
      @authority_lookup_param = :api_key
      @authority_lookup_field = :api_key
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
